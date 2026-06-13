# 고팡(Gopang) 사용자 시나리오 테스트 마스터 계획서

**문서 ID**: GOPANG-TEST-PLAN-v1.1  
**작성일**: 2026-06-13  
**갱신일**: 2026-06-13  
**작성**: AI City Inc. 팀 주피터  
**상태**: ✅ 확정

### 변경 이력
| 버전 | 날짜 | 변경 내용 |
|------|------|----------|
| v1.0 | 2026-06-13 | 최초 작성 |
| v1.1 | 2026-06-13 | 4가지 결정사항 반영 — GDC/API키/Chrome/DB |

---

## 목차

1. [목적 및 범위](#1-목적-및-범위)
2. [전체 구조](#2-전체-구조)
3. [Phase 0 — 계획 및 설계](#3-phase-0--계획-및-설계)
4. [Phase 1 — Supabase 데이터 생성](#4-phase-1--supabase-데이터-생성)
5. [Phase 2 — Profile 페이지 구성](#5-phase-2--profile-페이지-구성)
6. [Phase 3 — AI 비서 설정](#6-phase-3--ai-비서-설정)
7. [Phase 4 — 테스트 실행](#7-phase-4--테스트-실행)
8. [Phase 5 — 결과 문서화](#8-phase-5--결과-문서화)
9. [역할 분담](#9-역할-분담)
10. [일정](#10-일정)
11. [전제 조건 및 제약](#11-전제-조건-및-제약)
12. [용어 정의](#12-용어-정의)

---

## 1. 목적 및 범위

### 목적

고팡(Gopang) Profile 2.0 시스템을 실제 브라우저 환경에서 검증한다.  
100명의 가상 사용자가 일상에서 고팡을 활용하는 500개 시나리오를 순서대로 실행하고,  
그 과정과 결과를 문서화하여 누구나 독립적으로 테스트를 재현할 수 있도록 한다.

### 범위

| 포함 | 제외 |
|------|------|
| users.gopang.net 전 기능 | gopang.net GWP 내부 로직 |
| Cloudflare Worker API | L1 PocketBase 블록체인 레이어 |
| Supabase DB 연동 | OpenHash L2/L3 앵커링 |
| AI 비서 (DeepSeek) | 결제 실머니 GDC 충전 |
| 커뮤니티 게시판 | 외부 정부 API 연동 |
| 위치 기반 검색 | 모바일 앱(PWA) 설치 |

### 테스트 대상 기능 (M01~M14)

| 모듈 | 기능 | 테스트 여부 |
|------|------|-------------|
| M01 | 인증 (JWT 발급·갱신) | ✅ |
| M02 | 등록 (소비자·사업자·기관) | ✅ |
| M03 | QR 결제 | ✅ |
| M04 | 프로필 조회·다국어 번역 | ✅ |
| M05 | AI 비서·에스컬레이션 | ✅ |
| M06 | 리뷰 작성·국적별 필터 | ✅ |
| M07 | 위치 검색·길찾기 | ✅ |
| M08 | 국적별 히트맵 | 부분 (데이터 누적 후) |
| M09 | 커뮤니티 게시판 | ✅ |
| M10 | GDC 원장 | ✅ (결제 통해 간접) |
| M11 | PDV Hash Chain 감사 | 부분 (Supabase 확인) |
| M12 | 다국어 검색 | ✅ |
| M13 | 보안 스코어링 | 부분 (스팸 시나리오) |
| M14 | 대량 등록 | ✅ (Phase 1에서 활용) |

---

## 2. 전체 구조

```
Phase 0   계획 및 설계
  └─ 마스터 계획서 작성 (이 문서)
  └─ 사용자 100명 확정
  └─ 시나리오 매핑 (누가 어디서 무엇을)

Phase 1   Supabase 데이터 생성
  └─ 1-A: 100명 user_profiles INSERT
  └─ 1-B: 사업자/기관 extra JSONB 구성 (메뉴, 영업시간 등)
  └─ 1-C: 데이터 검증 (GUID 결정성, 중복 확인)

Phase 2   Profile 페이지 구성
  └─ 2-A: 각 사업자/기관 profile.html 동작 확인
  └─ 2-B: 다국어 번역 표시 확인
  └─ 2-C: QR 이미지 생성 확인

Phase 3   AI 비서 설정
  └─ 3-A: user_llm_keys INSERT (DeepSeek API 키)
  └─ 3-B: 각 업체별 system prompt 작성
  └─ 3-C: AI 비서 동작 확인

Phase 4   테스트 실행
  └─ 사용자 U01 → U100 순서대로
  └─ 각 사용자당 시나리오 5건
  └─ 결과 기록 (통과/실패/비고)

Phase 5   결과 문서화
  └─ summary.md 갱신
  └─ issues.md 버그 목록
  └─ GitHub push
```

---

## 3. Phase 0 — 계획 및 설계

### 3.1 사용자-업체 매핑 설계

테스트 시나리오는 소비자가 특정 업체/기관을 방문하는 구조입니다.  
아래는 시나리오에 등장하는 주요 업체/기관 목록입니다.

#### 등록 필요 업체·기관 (Phase 1 생성 대상)

| handle | 업체/기관명 | 유형 | 운영자 | 시나리오 활용 사용자 |
|--------|-------------|------|--------|----------------------|
| @hallim_geumneung | 금능반점 | org | U02 김민준 | U01 천웨이, U03 Yuki, U08 Somchai |
| @hallim_minjak | 이정호 민박 | org | U07 이정호 | U45 Emma, U83 Thomas |
| @hyeopjae_cafe | 협재 카페 | org | U22 송하늘 | U09 최은서, U33 장쉐 |
| @hallim_health | 한림읍 보건소 | institution | U04 박지수 | U05 Lan, U39 Mai |
| @hallim_hospital | 한림병원 | institution | U15 한도현 | U34 류창, U82 Laura |
| @hallim_pharmacy | 한림약국 | org | U16 신유림 | U78 Anong, U87 Fatima |
| @hallim_school | 한림초등학교 | institution | U17 조성민 | U18 권미래, U43 Sarah |
| @hallim_hanjung | 최미경 한의원 | org | U53 최미경 | U36 Aiko, U73 Takeshi |
| @hallim_dental | 문성준 치과 | org | U64 문성준 | U31 왕팡, U72 자오리 |
| @hallim_cityhall | 제주시청 민원실 | institution | U11 강현우 | U38 Tran, U76 Hung |
| @hallim_office | 한림읍사무소 | institution | U12 오수진 | U68 임현수, U69 최다은 |
| @hallim_geumneung_farm | 정우성 감귤 농장 | org | U23 정우성 | U37 Hiroshi, U60 조현배 |
| @hallim_blackpig | 김태호 흑돼지 목장 | org | U100 김태호 | U46 Hans, U86 Ivan |
| @hallim_doye | 박선미 도예 공방 | org | U61 박선미 | U47 Sofia, U84 Isabelle |
| @hallim_diving | 신재혁 다이빙 | org | U62 신재혁 | U44 Michael, U83 Thomas |
| @hallim_doejang | 김복순 된장 | org | U89 김복순 | U71 오제, U73 Takeshi |
| @hallim_realestate | 박은주 부동산 | org | U91 박은주 | U32 리밍, U44 Michael |
| @hallim_seafood | 한정수 수산물 | org | U58 한정수 | U86 Ivan, U42 Jose |
| @hallim_viet | Nguyen Van Binh 베트남 음식점 | org | U40 Nguyen | U05 Lan, U75 Hoa |
| @hallim_massage | Siriporn 마사지 | org | U41 Siriporn | U77 Preaw, U78 Anong |
| @hallim_travel | Kenji 여행사 | org | U35 Kenji | U03 Yuki, U36 Aiko |
| @hallim_olleh | 조민규 올레길 가이드 | org | U98 조민규 | U45 Emma, U83 Thomas |
| @hallim_welfare | 한림읍 복지관 | institution | U68 임현수 | U24 나지현, U69 최다은 |
| @hallim_119 | 한림 119 안전센터 | institution | U95 이소현 | U21 문재원, U92 최영훈 |
| @hallim_lawoffice | 임서연 법률 사무소 | org | U14 임서연 | U13 윤태양, U29 장민석 |
| @hallim_directfarm | 백지영 농산물 직거래 | org | U67 백지영 | U23 정우성, U54 오준호 |
| @hallim_convenience | 편의점 | org | U20 백예진 | U08 Somchai, U88 Amara |
| @hallim_pension | 숙박업소 | org | U55 정소영 | U47 Sofia, U84 Isabelle |

> 총 28개 업체/기관. 소비자 전용 사용자(관광객 등)는 별도 업체 운영 없음.

### 3.2 시나리오 유형 분류

500건의 시나리오는 아래 10개 유형으로 구성합니다.

| 유형 코드 | 유형명 | 설명 | 목표 비율 |
|-----------|--------|------|-----------|
| T1 | 신규 등록 | 처음 고팡을 등록하는 과정 | 20% |
| T2 | 프로필 조회 | 업체/기관 프로필 + 다국어 번역 | 15% |
| T3 | AI 비서 상담 | 메뉴 문의, 예약, 길 안내 | 20% |
| T4 | QR 결제 | pay.html 결제 완료 | 15% |
| T5 | 리뷰 작성 | 구매 후 다국어 리뷰 | 10% |
| T6 | 커뮤니티 | 게시글 작성·답변·해결 | 8% |
| T7 | 위치 검색 | /nearby, /search, /directions | 5% |
| T8 | 사업자 등록 | register.html 3-step | 4% |
| T9 | 기관 서비스 | 민원, 보건소, 학교 등 | 2% |
| T10 | 에스컬레이션 | AI 실패 → 사람 연결 | 1% |

---

## 4. Phase 1 — Supabase 데이터 생성

### 4.1 목표

Supabase `user_profiles` 테이블에 100명의 레코드를 생성한다.

### 4.2 작업 항목

#### 1-A: SQL 생성 (Claude 담당)

`gopang/sql/` 폴더에 아래 파일들을 작성한다.

```
sql/
├── phase2_users_insert.sql       ← 100명 user_profiles INSERT
├── phase2_biz_extra.sql          ← 사업자 extra JSONB (메뉴, 영업시간)
└── phase2_institution_extra.sql  ← 기관 extra JSONB
```

각 INSERT 구조:
```sql
INSERT INTO user_profiles (
  guid, entity_type, name, handle,
  native_lang, is_public, address, extra
) VALUES (
  '34c74aef-a50e-5c1d-be21-eae8e6d72225',  -- GUID (사전 계산)
  'consumer',
  '陈伟',
  '@consumer_chenwei',
  'zh', true,
  '제주특별자치도 제주시 한림읍',
  '{}'::jsonb
) ON CONFLICT (guid) DO UPDATE SET
  name = EXCLUDED.name,
  updated_at = now();
```

#### 1-B: 사업자 extra JSONB 구성

업체별로 메뉴, 영업시간, AI 비서 여부를 포함한다.

```json
{
  "phone": "064-796-0003",
  "business_hours": "11:00-21:00",
  "closed_days": "매주 월요일",
  "gdc_accepted": true,
  "ai_active": true,
  "menu": [
    {"id": "m001", "name": "짜장면", "price": 7000, "desc": "춘장 소스 중화 면"},
    {"id": "m002", "name": "짬뽕",   "price": 8000, "desc": "매운 해물 국물 면"},
    {"id": "m003", "name": "탕수육", "price": 18000, "desc": "바삭한 탕수육"}
  ],
  "fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}
}
```

#### 1-C: 실행 방법 (주피터님 담당)

```
테스트 전용 Supabase 프로젝트 대시보드 → SQL Editor
→ phase2_users_insert.sql 붙여넣기 → Run
→ phase2_biz_extra.sql 붙여넣기 → Run
→ phase2_institution_extra.sql 붙여넣기 → Run
→ phase2_gdc_balance.sql 붙여넣기 → Run  ← GDC 초기 잔액
```

#### 1-D: GDC 초기 잔액 직접 INSERT ✅ 확정

결제 시나리오(T4) 테스트를 위해 소비자 계정에 GDC 잔액을 직접 부여합니다.

```sql
-- phase2_gdc_balance.sql
-- 소비자 72명에게 각 ₮500,000 지급 (테스트용)
INSERT INTO fs_ledger (
  guid, entry_type, direction, amount, source, memo
)
SELECT
  guid,
  'bs-cash',
  'credit',
  500000,
  'manual',
  '테스트용 초기 GDC 잔액 지급'
FROM user_profiles
WHERE entity_type = 'consumer';

-- 지급 후 user_profiles.extra.fs 갱신
UPDATE user_profiles
SET extra = jsonb_set(
  COALESCE(extra, '{}'),
  '{fs}',
  '{"bs-cash": 500000, "pl-purchase": 0, "pl-revenue": 0}'::jsonb
)
WHERE entity_type = 'consumer';
```

> 지급 금액 ₮500,000은 테스트 시나리오 최대 결제액(₮50,000) × 10회를 커버합니다.

#### 1-E: 검증

```sql
-- 전체 건수 확인
SELECT entity_type, COUNT(*) FROM user_profiles GROUP BY entity_type;

-- 기대값
-- consumer:    72명
-- org:         20개 업체
-- institution:  8개 기관
```

### 4.3 산출물

| 파일 | 위치 | 담당 |
|------|------|------|
| phase2_users_insert.sql | gopang/sql/ | Claude |
| phase2_biz_extra.sql | gopang/sql/ | Claude |
| phase2_institution_extra.sql | gopang/sql/ | Claude |
| phase2_gdc_balance.sql | gopang/sql/ | Claude |

---

## 5. Phase 2 — Profile 페이지 구성

### 5.1 목표

각 업체/기관의 profile.html이 정상 동작하고  
다국어 번역, 메뉴 표시, AI 비서 탭이 올바르게 표시되는지 확인한다.

### 5.2 작업 항목

#### 2-A: 브라우저 확인 체크리스트 (주피터님 담당)

28개 업체/기관 각각에 대해:

```
https://users.gopang.net/profile.html?handle={handle}

확인 항목:
□ 업체명 표시
□ 메뉴/서비스 목록 표시
□ 영업시간 표시
□ [AI비서] 탭 표시 (ai_active=true인 경우)
□ 중국어(zh-CN) 전환 시 번역 표시
□ QR 이미지 (/qr/:handle) 정상 생성
```

#### 2-B: QR 이미지 확인

```
https://gopang-proxy.tensor-city.workers.dev/qr/@hallim_geumneung
→ SVG 이미지 반환 확인
```

### 5.3 산출물

| 항목 | 위치 | 담당 |
|------|------|------|
| Profile 확인 체크리스트 | gopang-test/results/phase2_profile_check.md | 주피터님 |

---

## 6. Phase 3 — AI 비서 설정

### 6.1 목표

AI 비서가 활성화된 업체/기관에 DeepSeek API 키와  
업체별 맞춤 system prompt를 등록한다.

### 6.2 작업 항목

#### 3-A: user_llm_keys INSERT ✅ 단일 DeepSeek 키 공유 확정

모든 업체가 Cloudflare 환경변수 `DEEPSEEK_API_KEY`를 공유합니다.  
`user_llm_keys`의 `api_key_enc`는 플레이스홀더 값으로 INSERT하고,  
Worker가 실제 요청 시 환경변수에서 키를 읽습니다.

```sql
-- phase3_llm_keys.sql
-- 14개 AI 비서 활성 업체에 공통 LLM 키 등록
INSERT INTO user_llm_keys (
  guid, provider, api_key_enc,
  model, custom_prompt, ai_active, native_lang
) VALUES
  ('{@hallim_geumneung GUID}', 'deepseek', 'shared_env_key',
   'deepseek-chat', '{금능반점 prompt}', true, 'ko'),
  ('{@hallim_hospital GUID}',  'deepseek', 'shared_env_key',
   'deepseek-chat', '{한림병원 prompt}', true, 'ko'),
  -- ... 14개 업체 전체
ON CONFLICT (guid) DO UPDATE SET
  custom_prompt = EXCLUDED.custom_prompt,
  ai_active = true,
  updated_at = now();
```

> `api_key_enc = 'shared_env_key'` 는 Worker가 환경변수를 사용하도록  
> 지정하는 특수 플래그값입니다. Worker 코드에서 이 값 감지 시  
> `env.DEEPSEEK_API_KEY`를 직접 사용합니다.

**Worker 수정 필요 사항** (`src/profile2.0/ai_assistant.js`):
```javascript
// api_key_enc === 'shared_env_key' 이면 환경변수 사용
const apiKey = llmKey.api_key_enc === 'shared_env_key'
  ? env.DEEPSEEK_API_KEY
  : await aesDecrypt(llmKey.api_key_enc, env.AES_ENCRYPTION_KEY);
```

#### 3-B: 업체별 System Prompt 작성 (Claude 담당)

각 업체마다 아래 구조로 system prompt를 작성한다.

```
[업체 기본 정보]
업체명: 금능반점
주소: 제주특별자치도 제주시 한림읍 한림리 123
전화: 064-796-0003
영업시간: 11:00-21:00 (월요일 휴무)

[메뉴 전체]
- 짜장면 ₮7,000: 춘장으로 볶은 중화 면 요리, 돼지고기와 양파 포함
- 짬뽕 ₮8,000: 해산물과 채소를 넣은 매운 국물 면
- 탕수육 ₮18,000: 바삭하게 튀긴 돼지고기에 새콤달콤 소스

[응대 규칙]
1. 메뉴에 없는 정보는 "잘 모르겠습니다. 직접 문의해 주세요"로 답한다.
2. 가격은 항상 GDC(₮) 단위로 안내한다.
3. 주문 의사가 확인되면 "주문을 진행할까요?"로 확인 후 결제를 안내한다.
4. 언어는 손님의 언어에 맞춰 응답한다.
```

#### 3-C: AI 비서 동작 확인 (주피터님 담당)

```
profile.html → [AI비서] 탭
→ 테스트 질문 입력
→ 응답 언어·내용 확인
```

### 6.3 AI 비서 적용 업체 목록

| handle | 업체명 | 언어 | prompt 특이사항 |
|--------|--------|------|----------------|
| @hallim_geumneung | 금능반점 | ko | 중화요리 메뉴 특화 |
| @hallim_hospital | 한림병원 | ko | 진료과목, 예약 안내, 의료 정보 제한 |
| @hallim_pharmacy | 한림약국 | ko | 약 정보 제한, 처방전 필요 안내 |
| @hallim_hanjung | 최미경 한의원 | ko | 한방 치료 항목, 예약 안내 |
| @hallim_dental | 문성준 치과 | ko | 진료 항목, 예약 안내 |
| @hallim_viet | 베트남 음식점 | vi/ko | 베트남어 우선 응대 |
| @hallim_massage | Siriporn 마사지 | th/ko | 태국어 우선, 코스 메뉴 |
| @hallim_doye | 박선미 도예 공방 | ko | 체험 프로그램, 예약 필수 |
| @hallim_diving | 신재혁 다이빙 | ko/en | 영어 병행, 안전 규칙 강조 |
| @hallim_olleh | 조민규 올레길 가이드 | ko/en | 코스별 난이도, 소요시간 |
| @hallim_travel | Kenji 여행사 | ja/ko | 일본어 우선, 패키지 안내 |
| @hallim_lawoffice | 임서연 법률 사무소 | ko | 법률 정보 제한, 상담 예약만 |
| @hallim_blackpig | 흑돼지 목장 | ko | 방문 예약, 체험 프로그램 |
| @hallim_geumneung_farm | 감귤 농장 | ko/ja | 직거래 판매, 체험 농장 |

### 6.4 산출물

| 파일 | 위치 | 담당 |
|------|------|------|
| phase3_llm_keys.sql | gopang/sql/ | Claude |
| prompts/SP-U02_geumneung.txt | gopang-test/assets/prompts/ | Claude |
| prompts/SP-U15_hospital.txt | gopang-test/assets/prompts/ | Claude |
| ... (28개) | gopang-test/assets/prompts/ | Claude |

---

## 7. Phase 4 — 테스트 실행

### 7.1 실행 순서

```
U01 (5건) → 완료 확인 → U02 (5건) → ... → U100 (5건)
```

### 7.2 각 사용자 테스트 절차

```
1. scenarios/Uxx_이름.md 파일 열기
2. assets/test_env_setup.md 환경 준비
3. S-01~S-05 순서대로 브라우저 테스트
4. 결과 기록 (통과/실패/비고)
5. 실패 시 issues.md에 버그 등록
6. 5건 완료 후 summary.md 갱신
7. git commit + push
```

### 7.3 합격 기준 (전체 공통)

| 기준 | 설명 |
|------|------|
| 기능 동작 | 시나리오 흐름이 오류 없이 완료 |
| 다국어 | 해당 언어로 UI·응답 표시 |
| DB 기록 | Supabase 관련 테이블에 레코드 생성 확인 |
| 성능 | AI 비서 응답 10초 이내 |

### 7.4 실패 처리

```
실패 발생 시:
  1. 증상 기록 (스크린샷 권장)
  2. issues.md에 ISS-NNN 등록
  3. Claude에게 증상 전달
  4. Claude: 원인 분석 + 수정 방향 제시
  5. 수정 후 재테스트
  6. 통과 시 다음 시나리오 진행
```

---

## 8. Phase 5 — 결과 문서화

### 8.1 문서 갱신 주기

| 문서 | 갱신 시점 |
|------|-----------|
| scenarios/Uxx.md | 각 사용자 테스트 완료 시 |
| results/summary.md | 각 사용자 완료 시 |
| results/issues.md | 실패 발생 즉시 |

### 8.2 GitHub 커밋 규칙

```
feat: Uxx 시나리오 완료 — 통과 x/5
fix: ISS-NNN 수정 — [증상 요약]
docs: summary.md 갱신 — Uxx~Uyy 완료
```

### 8.3 최종 보고서

전체 테스트 완료 후 `results/final_report.md` 작성:

```
- 전체 통과율
- 주요 발견 버그 목록
- 언어별 이슈 분포
- 모듈별 안정성 평가
- v1.1 개선 권고사항
```

---

## 9. 역할 분담

| 작업 | Claude | 주피터님 |
|------|--------|----------|
| SQL 파일 작성 (INSERT) | ✅ | |
| SQL 실행 (Supabase) | | ✅ |
| AI 비서 system prompt 작성 | ✅ | |
| user_llm_keys 등록 | ✅ SQL 제공 | ✅ 실행 |
| 브라우저 테스트 실행 | | ✅ |
| 테스트 결과 기록 | ✅ 문서 작성 | ✅ 결과 입력 |
| 실패 원인 분석 | ✅ | |
| 수정 코드 작성 | ✅ | |
| GitHub push | | ✅ |
| 최종 보고서 작성 | ✅ | ✅ 검토 |

---

## 10. 일정

| Phase | 작업 내용 | 담당 | 예상 소요 |
|-------|-----------|------|-----------|
| Phase 0 | 계획서 작성·확정 | 공동 | 1일 |
| Phase 0-B | 테스트 Supabase 프로젝트 생성 | 주피터님 | 1시간 |
| Phase 0-C | Chrome 프로필 6개 생성·언어 설정 | 주피터님 | 30분 |
| Phase 1-A | SQL 파일 작성 (users + biz + gdc) | Claude | 반나절 |
| Phase 1-B | SQL 실행·검증 | 주피터님 | 반나절 |
| Phase 2 | Profile 확인 | 주피터님 | 1일 |
| Phase 3-A | System prompt 작성 | Claude | 1일 |
| Phase 3-B | AI 비서 등록·확인 | 주피터님 | 반나절 |
| Phase 4 | 테스트 실행 (100명) | 주피터님 + Claude | 미정 |
| Phase 5 | 문서화·보고서 | 공동 | 지속 |

> Phase 4 소요 시간은 1명당 평균 30분 가정 시 약 50시간 (분산 진행 권장)

---

## 11. 전제 조건 및 제약

### 11.1 전제 조건

```
✅ users.gopang.net 배포 완료
✅ gopang-proxy Worker 운영 중
✅ DeepSeek API 키 보유 (DEEPSEEK_API_KEY 환경변수 등록)
✅ AES_ENCRYPTION_KEY Cloudflare 환경변수 등록 완료
✅ 금능반점(@hallim_geumneung) 기본 데이터 존재
✅ 테스트 전용 Supabase 프로젝트 생성 완료 (§11.2)
✅ 언어별 Chrome 프로필 생성 완료 (§11.3)
```

### 11.2 테스트 전용 Supabase 프로젝트 ✅ 확정

프로덕션 DB(`ebbecjfrwaswbdybbgiu`)와 완전 분리하여 테스트합니다.

**신규 프로젝트 생성 절차:**
```
1. https://supabase.com/dashboard → New project
2. 프로젝트명: gopang-test
3. 지역: Northeast Asia (Seoul) 권장
4. 생성 후 URL·anon key·service key 복사
5. gopang-proxy Worker에 테스트용 환경변수 추가:
   SUPABASE_URL_TEST    = https://{신규}.supabase.co
   SUPABASE_KEY_TEST    = {신규 anon key}
   SUPABASE_SERVICE_KEY_TEST = {신규 service key}
6. 스키마 마이그레이션:
   gopang/sql/phase0_migration.sql → 신규 프로젝트 SQL Editor에서 실행
```

**테스트 환경 전환 방법:**
```
Worker URL 파라미터로 구분:
  ?env=test  → 테스트 Supabase 사용
  (기본값)   → 프로덕션 Supabase 사용
```
또는 테스트 기간 동안 Worker 환경변수를 임시로 교체하는 방법도 가능.  
→ **주피터님이 편한 방식 선택**

### 11.3 언어별 Chrome 프로필 ✅ 확정

Chrome 프로필을 언어별로 미리 만들어 두면 테스트 시 즉시 전환 가능합니다.

**프로필 생성 절차:**
```
Chrome 우상단 프로필 아이콘 → + 프로필 추가 → 이름 설정
```

| 프로필명 | 언어 설정 | 대상 사용자 |
|----------|-----------|-------------|
| Gopang-KO | 한국어 (ko-KR) | U02, U04, U07 등 한국인 |
| Gopang-ZH | 중국어 간체 (zh-CN) | U01, U31, U32, U33, U34, U71, U72 |
| Gopang-JA | 일본어 (ja-JP) | U03, U35, U36, U37, U73, U74 |
| Gopang-VI | 베트남어 (vi-VN) | U05, U38, U39, U40, U75, U76 |
| Gopang-TH | 태국어 (th-TH) | U08, U41, U77, U78 |
| Gopang-EN | 영어 (en-US) | U06, U43, U44, U45, U81, U82 등 |

**각 프로필 언어 설정:**
```
chrome://settings/languages
→ 언어 추가 → 해당 언어 → 맨 위로 이동 → Chrome 재시작
```

### 11.4 제약 사항

```
⚠️  DeepSeek API 비용 발생 → AI 비서 테스트 1건당 약 $0.001 예상
⚠️  외국인 전화번호 SMS 인증 불가 → 전화번호 직접 입력 방식 사용
⚠️  Web Speech API → 브라우저 마이크 허용 필요 (테스트 시 수동 허용)
⚠️  테스트 Supabase 스키마 → phase0_migration.sql 전체 실행 필요
```

### ✅ 확정된 결정사항 (2026-06-13)

| # | 항목 | 결정 | 비고 |
|---|------|------|------|
| 1 | GDC 잔액 확보 | **테스트용 fs_ledger 직접 INSERT** | Phase 1-D에서 SQL 작성 |
| 2 | AI 비서 API 키 | **단일 DeepSeek 키 공유** | Cloudflare 환경변수 DEEPSEEK_API_KEY 사용 |
| 3 | 외국어 브라우저 설정 | **별도 Chrome 프로필 생성** | 언어별 프로필 준비 (§11.3 참조) |
| 4 | 테스트 DB | **별도 Supabase 프로젝트** | 프로덕션 DB 분리 보호 |

---

## 12. 용어 정의

| 용어 | 정의 |
|------|------|
| GUID | uuidv5(전화번호 숫자, GOPANG_NS) — 결정성 UUID |
| JWT | gopang_token — HMAC-SHA256, 24시간 유효 |
| GDC | 고팡 디지털 화폐 (₮) |
| handle | @읍면동_이름 형식 업체 식별자 |
| entity_type | consumer / org / institution |
| ai_active | user_llm_keys 기준 AI 비서 활성 여부 |
| fs_ledger | 금융 원장 — 거래당 3행 (buyer/seller/platform) |
| PDV | 거래 증거 데이터 — Hash Chain 무결성 보장 |
| T1~T10 | 시나리오 유형 코드 (§3.2 참조) |

---

## 부록: 진행 체크리스트

### Phase 0 완료 기준
- [ ] 테스트 전용 Supabase 프로젝트 생성 완료
- [ ] phase0_migration.sql 테스트 DB에 실행 완료
- [ ] Chrome 프로필 6개 생성 완료 (KO/ZH/JA/VI/TH/EN)
- [ ] Worker 환경변수 테스트 DB 연결 확인
- [ ] DEEPSEEK_API_KEY 환경변수 등록 확인

### Phase 1 완료 기준
- [ ] user_profiles: consumer 72건 확인
- [ ] user_profiles: org 20건 확인
- [ ] user_profiles: institution 8건 확인
- [ ] 모든 GUID 결정성 검증 완료
- [ ] 사업자 extra JSONB (메뉴, 영업시간) 확인

### Phase 2 완료 기준
- [ ] 28개 업체/기관 profile.html 정상 표시
- [ ] 다국어 번역 (zh/ja/vi/th) 동작 확인
- [ ] QR 이미지 28개 생성 확인

### Phase 3 완료 기준
- [ ] user_llm_keys 14개 INSERT 완료
- [ ] 14개 업체 AI 비서 응답 확인
- [ ] system prompt 업체별 적용 확인

### Phase 4 완료 기준
- [ ] U01~U100 전체 테스트 실행
- [ ] 전체 500건 결과 기록
- [ ] 실패 이슈 전체 처리 완료

### Phase 5 완료 기준
- [ ] summary.md 최종 통계 갱신
- [ ] final_report.md 작성 완료
- [ ] GitHub 전체 push 완료

---

*GOPANG-TEST-PLAN-v1.1 · AI City Inc. · 2026-06-13*  
*4가지 결정사항 반영 확정 — GDC직접INSERT / DeepSeek단일키 / Chrome프로필 / 별도Supabase*
