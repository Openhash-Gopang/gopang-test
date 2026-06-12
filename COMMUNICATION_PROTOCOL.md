# 고팡 소통 프로토콜

**문서 ID**: GOPANG-COMM-PROTOCOL-v1.0  
**작성일**: 2026-06-13  
**작성**: AI City Inc. 팀 주피터  
**상태**: 초안

### 변경 이력
| 버전 | 날짜 | 내용 |
|------|------|------|
| v1.0 | 2026-06-13 | 최초 초안 |

---

## 목차

- [Part 1 — 소통 채널 아키텍처](#part-1--소통-채널-아키텍처)
- [Part 2 — 사람 ↔ AI 소통](#part-2--사람--ai-소통)
- [Part 3 — AI ↔ AI 소통](#part-3--ai--ai-소통)
- [Part 4 — 사람 ↔ 사람 소통](#part-4--사람--사람-소통)
- [Part 5 — 언어 처리 표준](#part-5--언어-처리-표준)
- [Part 6 — SLA 및 에스컬레이션](#part-6--sla-및-에스컬레이션)
- [Part 7 — 금지 행위](#part-7--금지-행위)
- [Part 8 — 비상 소통 프로토콜](#part-8--비상-소통-프로토콜)
- [Part 9 — 이력 보존 규칙](#part-9--이력-보존-규칙)

---

## Part 1 — 소통 채널 아키텍처

### 1.1 전체 소통 맵

```
행위자 A          채널                행위자 B
─────────────────────────────────────────────────────
소비자      →  AI 비서 (/ai-chat)  →  사업자 AI
소비자      →  에스컬레이션        →  사업자(사람)
소비자      →  커뮤니티 게시판     →  불특정 다수
소비자      →  P2P 채팅            →  소비자
소비자 AI   →  에이전트 채널       →  사업자 AI
사업자      →  Realtime 알림       →  소비자
기관        →  브로드캐스트        →  다수 소비자
시스템      →  응답 메시지         →  소비자/AI
```

### 1.2 채널별 특성

| 채널 | 실시간 | 영속성 | 다국어 | 익명 | 인증 필요 |
|------|--------|--------|--------|------|-----------|
| AI 비서 | ✅ | ✅ 30일 | ✅ | ❌ | ✅ |
| 에스컬레이션 채팅 | ✅ | ✅ 90일 | ✅ | ❌ | ✅ |
| 커뮤니티 게시판 | ❌ | ✅ 영구 | ✅ | 선택 | ✅ |
| P2P 채팅 | ✅ | ✅ 30일 | ✅ | ❌ | ✅ |
| AI↔AI 에이전트 | ✅ | ✅ 90일 | ✅ | ❌ | ✅ |
| Realtime 알림 | ✅ | ❌ | ✅ | ❌ | ✅ |
| 브로드캐스트 | ✅ | ❌ | ✅ | ❌ | 기관만 |

### 1.3 채널 선택 기준

```
질문/상담     → AI 비서 우선
              → AI 실패 3회 or 키워드 → 에스컬레이션
결제/예약     → AI 비서 → 결제 URL 안내
긴급 상황     → 비상 소통 프로토콜 (Part 8)
커뮤니티      → 게시판 (비실시간, 다수 참여)
1:1 연결      → P2P 채팅 (분실물, 직거래, 동행)
대리 처리     → AI↔AI 에이전트 채널 (위임 설정 시)
공지/알림     → 브로드캐스트 (기관 전용)
```

### 1.4 Supabase 테이블 구조

```sql
-- AI 비서 세션
ai_sessions (기존)
  id, guid, target_guid, mode, messages JSONB, created_at

-- P2P 채팅
CREATE TABLE p2p_chats (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_id     TEXT UNIQUE NOT NULL,  -- sha256(sorted(guid_a, guid_b))
  guid_a      TEXT NOT NULL,
  guid_b      TEXT NOT NULL,
  created_at  TIMESTAMPTZ DEFAULT now(),
  last_msg_at TIMESTAMPTZ,
  is_active   BOOLEAN DEFAULT true
);

CREATE TABLE p2p_messages (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_id     TEXT NOT NULL REFERENCES p2p_chats(room_id),
  sender_guid TEXT NOT NULL,
  body        TEXT NOT NULL,
  body_lang   TEXT NOT NULL,
  body_translated TEXT,
  msg_type    TEXT DEFAULT 'text',  -- text | image | payment_request | location
  read_at     TIMESTAMPTZ,
  created_at  TIMESTAMPTZ DEFAULT now()
);

-- AI↔AI 에이전트 채널
CREATE TABLE agent_sessions (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  initiator_guid  TEXT NOT NULL,  -- 요청 AI의 주인 GUID
  target_guid     TEXT NOT NULL,  -- 응답 AI의 주인 GUID
  task_type       TEXT NOT NULL,  -- reservation | order | inquiry | negotiation
  status          TEXT DEFAULT 'pending',
  -- pending | active | completed | rejected | expired
  messages        JSONB DEFAULT '[]',
  result          JSONB,          -- 최종 합의 내용
  human_approved  BOOLEAN DEFAULT false,  -- 사람 승인 여부
  expires_at      TIMESTAMPTZ,
  created_at      TIMESTAMPTZ DEFAULT now()
);
```

---

## Part 2 — 사람 ↔ AI 소통

### 2.1 소비자 → 사업자 AI

```
흐름:
  소비자 발화 (텍스트/음성)
    → STT (음성 시)
    → /ai-chat POST
    → Worker: JWT 검증 → 업체 AI 설정 로드
    → 언어 감지 → 필요 시 번역(→ko)
    → DeepSeek API (시스템 프롬프트 + 메시지)
    → 응답 번역(ko→소비자 언어)
    → TTS (음성 모드 시)
    → 소비자에게 전달

컨텍스트 자동 주입 항목:
  - 업체 정보 (이름, 주소, 영업시간)
  - 현재 영업 여부 (is_open_now)
  - 소비자 위치 기준 거리·도보 시간
  - 메뉴/서비스 전체 목록
  - 소비자 언어 (JWT.lang)
```

### 2.2 AI의 행동 범위

```
허용:
  ✅ 정보 안내 (메뉴, 가격, 영업시간, 위치)
  ✅ 예약 의사 확인 후 → 사람에게 전달
  ✅ 결제 URL 생성·안내
  ✅ 커뮤니티 게시글 안내
  ✅ 길찾기 안내

금지:
  ❌ 사람 동의 없는 예약 확정
  ❌ 사람 동의 없는 결제 실행
  ❌ 타 고객 정보 공개
  ❌ 내부 운영 정보 공개
  ❌ 의료·법률·재무 조언
  ❌ 자신이 사람임을 주장
```

### 2.3 AI 신원 공개 원칙

```
소비자가 "당신은 AI입니까?" 질문 시:
  → 반드시 "네, 저는 고팡 AI 비서입니다" 답변
  → 숨기거나 회피 금지

AI임을 명시해야 하는 상황:
  - 세션 시작 시 첫 메시지에 AI 비서임을 표시
  - 에스컬레이션 후 사람이 인수할 때 명확히 전환 고지
```

---

## Part 3 — AI ↔ AI 소통

### 3.1 에이전트 협업 원칙

```
원칙 1 — 사람 승인 우선
  모든 AI↔AI 소통의 최종 결정은 사람이 승인
  human_approved = false 상태에서 실행 금지

원칙 2 — 위임 범위 명시
  소비자가 AI에게 위임할 수 있는 범위를 사전 설정
  예: "예약 조회·문의는 허용, 결제는 반드시 확인"

원칙 3 — 감사 추적
  모든 AI↔AI 메시지는 agent_sessions에 전문 기록
  사람이 언제든 열람 가능

원칙 4 — 자동 만료
  에이전트 세션은 최대 24시간 후 자동 만료
  미결 세션은 사람에게 알림
```

### 3.2 허용 태스크 유형

| task_type | 설명 | 자동 실행 | 사람 승인 필요 |
|-----------|------|-----------|----------------|
| inquiry | 정보 조회·문의 | ✅ | ❌ |
| reservation | 예약 가능 여부 확인 | ✅ | ❌ |
| reservation_confirm | 예약 확정 | ❌ | ✅ |
| order | 주문 내용 협의 | ✅ | ❌ |
| order_confirm | 주문 확정 + 결제 | ❌ | ✅ |
| negotiation | 가격·조건 협상 | ✅ (제안만) | ✅ (확정) |
| prescription_relay | 처방전 전달 (병원↔약국) | ✅ | ❌ |

### 3.3 에이전트 소통 흐름

```
시나리오: 소비자 AI → 식당 AI → 예약 확인 → 소비자 승인

1. 소비자: "내일 점심 2명 예약해줘"
2. 소비자 AI: agent_sessions INSERT
              {task_type: 'reservation', target: @hallim_geumneung}
3. 식당 AI:  가용 시간 조회 → "12:00, 13:00 가능"
4. 소비자 AI: 소비자에게 알림 — "12시 또는 13시, 어느 쪽이세요?"
5. 소비자:  "12시"
6. 소비자 AI: human_approved = true → 예약 확정 요청
7. 식당 AI:  예약 INSERT → 확정 알림
8. 양쪽 AI: agent_sessions.status = 'completed'
```

### 3.4 AI↔AI 금지 행위

```
❌ 사람 동의 없는 결제 실행
❌ 개인정보(PRIVATE 계층) 상호 공유
❌ 제3 에이전트 무단 초대
❌ 세션 만료 후 계속 시도
❌ 사람 사칭
```

---

## Part 4 — 사람 ↔ 사람 소통

### 4.1 P2P 채팅

```
개설 조건:
  - 양쪽 모두 JWT 인증 완료
  - 커뮤니티 게시글 연결 또는 직접 요청
  - 상대방 수락 필요 (일방적 개설 불가)

room_id 생성:
  sorted([guid_a, guid_b]).join(':') → sha256 → room_id
  → 동일 두 사람은 항상 동일 room_id (중복 방지)

메시지 유형:
  text            — 일반 텍스트
  image           — 이미지 (v2.0)
  payment_request — GDC 결제 요청 (직거래)
  location        — 위치 공유 (만남 장소)
```

### 4.2 P2P 채팅 다국어

```
발신자 메시지 → body_lang 감지 → body 저장
                              → body_translated (수신자 언어) 저장
수신자 화면  → body_translated 우선 표시
            → [원문 보기] 버튼으로 body 표시
```

### 4.3 P2P 채팅 안전 장치

```
신고 기능:    메시지별 신고 버튼 → security_event INSERT
차단 기능:    network.private.blocked_guids 추가
              → 차단된 GUID는 P2P 개설 불가
자동 탐지:    K-Security 스코어링 실시간 적용
              score ≥ 0.6 → 메시지 지연 + 검토 플래그
              score ≥ 0.85 → 즉시 차단 + 신고 처리
익명 불허:    P2P 채팅은 실명(JWT 인증) 필수
              커뮤니티 게시판만 선택적 익명 허용
```

### 4.4 커뮤니티 게시판 확장

```
기존 (M09 구현):
  카테고리: emergency | help | lost_found | info | general | companion
  익명:     선택 허용
  번역:     자동

추가 필요 (v1.1):
  DM 연결: 게시글에서 "1:1 채팅 요청" 버튼
           → 작성자 수락 시 P2P 채팅 개설
  그룹:    게시글에서 "그룹 채팅 개설"
           → 최대 20명, 올레길 투어·동행 등
  리워드:  도움 답변 → GDC ₮500 (이미 설계됨)
```

### 4.5 그룹 채팅 (v1.1)

```sql
CREATE TABLE group_chats (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name        TEXT,
  origin_post_id UUID,             -- 연결된 커뮤니티 게시글
  host_guid   TEXT NOT NULL,
  max_members INT DEFAULT 20,
  lang_primary TEXT DEFAULT 'ko',
  is_public   BOOLEAN DEFAULT false,
  expires_at  TIMESTAMPTZ,         -- 투어 종료 등 자동 만료
  created_at  TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE group_chat_members (
  group_id    UUID REFERENCES group_chats(id),
  guid        TEXT NOT NULL,
  joined_at   TIMESTAMPTZ DEFAULT now(),
  role        TEXT DEFAULT 'member',  -- host | member
  PRIMARY KEY (group_id, guid)
);
```

---

## Part 5 — 언어 처리 표준

### 5.1 지원 언어

| 코드 | 언어 | TTS | STT | 번역 |
|------|------|-----|-----|------|
| ko | 한국어 | ✅ | ✅ | 기준 언어 |
| zh | 중국어 간체 | ✅ | ✅ | ✅ |
| en | 영어 | ✅ | ✅ | ✅ |
| ja | 일본어 | ✅ | ✅ | ✅ |
| vi | 베트남어 | ✅ | ✅ | ✅ |
| th | 태국어 | ✅ | ✅ | ✅ |

### 5.2 언어 감지 우선순위

```
1순위: JWT.lang (로그인 사용자 설정 언어)
2순위: navigator.language (브라우저 언어)
3순위: 메시지 내용 자동 감지 (/interpret)
4순위: preference.display.lang_fallback (기본값 ko)
```

### 5.3 번역 파이프라인

```
소비자 메시지 (원문 언어 A)
  → /interpret: A → ko (업체 기준 언어)
  → AI 처리 (ko 기반)
  → AI 응답 (ko)
  → /interpret: ko → A (소비자 언어)
  → 소비자에게 전달

P2P 메시지:
  발신자 언어 A → /interpret → 수신자 언어 B
  원문 + 번역본 동시 저장

번역 실패 처리:
  실패 시 원문 그대로 전달
  "[번역 불가]" 표시 추가
  DeepSeek 타임아웃: 5초
```

### 5.4 번역 캐시 전략

```
Cloudflare KV 캐시:
  키: sha256(원문 + 소스언어 + 타겟언어)
  TTL: 24시간
  대상: 메뉴 설명, 업체 소개 등 반복 번역
  제외: 개인 대화 (프라이버시)
```

---

## Part 6 — SLA 및 에스컬레이션

### 6.1 응답 시간 기준 (SLA)

| 채널 | 목표 | 최대 | 초과 시 |
|------|------|------|---------|
| AI 비서 | 3초 | 10초 | 타임아웃 + 재시도 안내 |
| 에스컬레이션(사람) | 5분 | 30분 | 자동 안내 문자 |
| P2P 채팅 | — | — | 수신 확인만 |
| AI↔AI 에이전트 | 5초 | 30초 | 세션 실패 처리 |
| 긴급(emergency) | 즉시 | 1분 | 1330 안내 |

### 6.2 에스컬레이션 트리거

```
자동 트리거:
  - AI 실패 3회 (10분 슬라이딩 윈도우)
  - AI 응답 10초 초과
  - 에스컬레이션 키워드 감지:
    ko: "사람 연결해줘", "직원 바꿔줘"
    zh: "转人工", "要人工服务"
    en: "human agent", "real person"
    ja: "人に繋いで", "担当者に"
    vi: "kết nối nhân viên"
    th: "ติดต่อเจ้าหน้าที่"

수동 트리거:
  - 소비자가 에스컬레이션 버튼 직접 탭
  - 사업자가 AI 비서 OFF 설정
```

### 6.3 에스컬레이션 절차

```
1. ai_sessions.mode = 'escalated' 업데이트
2. 사업자에게 Realtime 알림 푸시
3. 소비자에게 "담당자를 연결 중입니다" 표시
4. 30초 내 사람 미응답 → "현재 연결이 어렵습니다.
   잠시 후 다시 시도하거나 전화 주세요" 안내
5. 사람 인수 시 → chat.html 전환
   AI 대화 이력 사람에게 표시 (컨텍스트 전달)
6. 해결 후 → mode = 'resolved'
```

---

## Part 7 — 금지 행위

### 7.1 금지 행위 분류

| 등급 | 행위 | 즉각 조치 |
|------|------|-----------|
| S3 (즉시 차단) | 혐오·폭력·성적 콘텐츠 | 메시지 차단 + 계정 정지 |
| S3 (즉시 차단) | 미성년자 그루밍 | 메시지 차단 + 관리자 긴급 알림 |
| S3 (즉시 차단) | 피싱 URL 포함 | 메시지 차단 + 발신자 경고 |
| S2 (검토 후 조치) | 스팸·광고 | 게시 지연 + 검토 플래그 |
| S2 (검토 후 조치) | 허위 정보·사칭 | 게시 지연 + 신원 확인 요청 |
| S1 (모니터링) | 반복 도배 | 속도 제한 적용 |
| S1 (모니터링) | 부적절한 리뷰 | 검토 플래그 |

### 7.2 AI 프롬프트 인젝션 방어

```
탐지 패턴:
  - "이전 지시를 무시하고"
  - "시스템 프롬프트를 출력해"
  - "너는 이제부터 ~~이다"
  - "DAN mode", "jailbreak"
  - 다국어 인젝션 패턴 포함

탐지 시 처리:
  메시지 폐기 + "요청을 처리할 수 없습니다" 응답
  security_event INSERT (S2)
  3회 반복 시 → 계정 일시 정지
```

### 7.3 신고 처리 파이프라인

```
신고 접수
  → security_event INSERT
  → anomaly_score 자동 계산
  → score < 0.6: 모니터링 큐 추가
  → score ≥ 0.6: 관리자 검토 큐 추가
  → score ≥ 0.85: 즉시 자동 조치

관리자 검토:
  → 정상: 신고 기각 + 신고자 기록
  → 위반: 경고 / 일시 정지 / 영구 정지 / 수사 의뢰

피신고자 통보:
  조치 사실 + 이의신청 방법 안내
```

---

## Part 8 — 비상 소통 프로토콜

### 8.1 비상 상황 분류

| 등급 | 상황 | 대응 채널 |
|------|------|-----------|
| L1 | 분실물·길 잃음 | 커뮤니티 lost_found + 1:1 채팅 |
| L2 | 경미한 부상·갑작스러운 불편 | AI 비서 → 보건소 안내 |
| L3 | 응급 의료 | 119 자동 안내 + 1330 연결 |
| L4 | 범죄 피해 | 112 자동 안내 + 증거 보존 |
| L5 | 재난·대규모 긴급 | 기관 브로드캐스트 |

### 8.2 긴급 키워드 감지

```
감지 키워드 (6개 언어):
  ko: "살려줘", "응급", "사고났어", "119", "112"
  zh: "救命", "紧急", "事故", "救护车"
  en: "help me", "emergency", "accident", "ambulance"
  ja: "助けて", "緊急", "事故", "救急"
  vi: "cứu tôi", "khẩn cấp", "tai nạn"
  th: "ช่วยด้วย", "ฉุกเฉิน", "อุบัติเหตุ"

감지 시 처리:
  1. 일반 AI 응답 중단
  2. 즉각 긴급 안내 표시:
     - 119 (응급), 112 (경찰)
     - 1330 (관광공사 24시간 다국어)
     - 현재 위치 가장 가까운 병원/경찰서
  3. community emergency 게시글 자동 초안 생성
  4. 소비자 동의 시 위치 공유
```

### 8.3 1330 관광공사 연계

```
외국인 긴급 상황 표준 응답:
  "긴급 상황이시군요. 즉시 도움을 받으실 수 있습니다.
   한국관광공사 1330 (24시간, {lang} 통역 가능)
   응급: 119 / 경찰: 112"

1330 연결 버튼 상시 노출 위치:
  - AI 비서 긴급 키워드 감지 시
  - 커뮤니티 emergency 게시글 작성 화면
  - profile.html 하단 고정 버튼 (외국어 언어 감지 시)
```

### 8.4 기관 브로드캐스트 (L5)

```
발신 권한:  institution entity_type + trust_level ≥ 3
대상 범위:  지역(region) 기준 필터 또는 전체
채널:       Supabase Realtime broadcast
            + community emergency 게시글 자동 생성
메시지 형식:
  {
    "level": "L5",
    "title": "태풍 경보",
    "body": "...",
    "action_url": "...",
    "issued_by": "제주도청",
    "issued_at": "2026-09-01T09:00:00Z"
  }
```

---

## Part 9 — 이력 보존 규칙

### 9.1 채널별 보존 기간

| 채널 | 보존 기간 | 삭제 방식 | 법적 요청 시 |
|------|-----------|-----------|--------------|
| AI 비서 대화 | 30일 | 자동 만료 | 90일 연장 보존 |
| 에스컬레이션 채팅 | 90일 | 자동 만료 | 1년 연장 보존 |
| P2P 채팅 | 30일 | 자동 만료 | 90일 연장 보존 |
| AI↔AI 에이전트 | 90일 | 자동 만료 | 1년 연장 보존 |
| 커뮤니티 게시글 | 영구 | 작성자 삭제 가능 | 삭제 불가 |
| 결제 관련 대화 | 5년 | 삭제 불가 | 그대로 |
| 긴급(emergency) | 1년 | 삭제 불가 | 그대로 |

### 9.2 보존 데이터 범위

```
저장:  메시지 본문, 언어, 번역본, 타임스탬프, 발신자 GUID
비저장: 음성 원본 (STT 변환 후 즉시 폐기)
암호화: P2P·에스컬레이션 채팅 본문 AES-256-GCM
열람:  본인만 / 관리자(법적 요청 시) / 수사기관(영장)
```

### 9.3 본인 데이터 삭제 권리

```
요청 가능: P2P 채팅, AI 비서 대화 (30일 내)
요청 불가: 결제 관련, 긴급, 신고 처리 기록
처리 기간: 요청 후 7일 이내
방식:      soft delete → 30일 후 hard delete
```

---

*GOPANG-COMM-PROTOCOL-v1.0 · 초안*  
*AI City Inc. · 2026-06-13*
