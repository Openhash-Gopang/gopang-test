# 브라우저 테스트 환경 설정 가이드

---

## 1. Chrome 언어 설정

외국인 사용자 시나리오 테스트 시 Chrome 언어를 변경합니다.

```
chrome://settings/languages
→ 언어 추가 → 해당 언어 선택 → 맨 위로 이동
→ Chrome 재시작
```

| 사용자 국적 | 설정 언어 코드 |
|-------------|----------------|
| 중국 | zh-CN |
| 일본 | ja-JP |
| 베트남 | vi-VN |
| 태국 | th-TH |
| 필리핀/영어권 | en-US |
| 한국 | ko-KR (기본값) |

> 테스트 완료 후 반드시 ko-KR로 원복하세요.

---

## 2. Local Storage 초기화

매 사용자 테스트 시작 전 필수 수행합니다.

```
F12 → Application → Local Storage
→ https://users.gopang.net 선택
→ 우클릭 → Clear
```

초기화 대상 키:
- `gopang_token` — JWT 토큰
- `pending_pay_url` — 미완료 결제 URL
- `gopang_session` — 세션 정보

---

## 3. Supabase 대시보드 접근

테스트 결과 DB 확인용입니다.

```
URL: https://supabase.com/dashboard/project/ebbecjfrwaswbdybbgiu
경로: Table Editor → 해당 테이블 선택
```

자주 확인하는 테이블:

| 테이블 | 확인 내용 |
|--------|-----------|
| user_profiles | 등록 완료 여부, GUID, native_lang |
| biz_orders | 결제 완료 여부, amount, status |
| fs_ledger | 3행 생성 여부, direction, amount |
| profile_reviews | reviewer_lang, body_translated |
| community_posts | lang, category, body_translated |
| ai_sessions | mode, messages |

---

## 4. Unix Timestamp 확인

pay.html URL의 `created_at` 파라미터에 필요합니다.

```
방법 1: https://www.unixtimestamp.com 접속
방법 2: Chrome 콘솔(F12)에서 실행
  > Math.floor(Date.now() / 1000)
```

---

## 5. JWT 토큰 확인

등록 완료 후 localStorage에서 토큰을 확인합니다.

```javascript
// Chrome 콘솔(F12)에서 실행
localStorage.getItem('gopang_token')
```

API 직접 테스트 시 Authorization 헤더에 사용합니다:
```
Authorization: Bearer {위 토큰 값}
```

---

## 6. 자주 발생하는 문제

| 증상 | 원인 | 해결 |
|------|------|------|
| profile.html이 한국어로 표시 | Chrome 언어 설정 미변경 | 1번 참조 |
| 로그인 화면으로 계속 리다이렉트 | gopang_token 만료 또는 없음 | Local Storage 확인 후 재등록 |
| pay.html에서 QR_EXPIRED 오류 | created_at + expires 초과 | URL의 created_at을 현재 timestamp로 교체 |
| AI 비서 탭이 보이지 않음 | 해당 업체 ai_active=false | Supabase user_llm_keys 확인 |
| 리뷰 작성 버튼 비활성 | 해당 업체 결제 tx_id 없음 | S-03 결제 먼저 완료 |

---

*test_env_setup.md v1.0 · AI City Inc. · 2026-06-13*
