# 고팡 PDV·OpenHash 프로토콜

**문서 ID**: GOPANG-PDV-OPENHASH-v1.0  
**작성일**: 2026-06-13  
**작성**: AI City Inc. 팀 주피터  
**상태**: 초안  
**근거**: OpenHash SCI 논문 v2.2, gopang_db_manual_v2.md, T01~T10 검증 완료

### 변경 이력
| 버전 | 날짜 | 내용 |
|------|------|------|
| v1.0 | 2026-06-13 | 최초 초안 |

---

## 목차

- [Part 1 — 개요 및 설계 철학](#part-1--개요-및-설계-철학)
- [Part 2 — PDV (Personal Data Vault)](#part-2--pdv-personal-data-vault)
- [Part 3 — OpenHash 5계층 구조](#part-3--openhash-5계층-구조)
- [Part 4 — PLSM (확률적 계층 선택)](#part-4--plsm-확률적-계층-선택)
- [Part 5 — Hash Chain 생성·검증](#part-5--hash-chain-생성검증)
- [Part 6 — BIVM (잔액 불변성 검증)](#part-6--bivm-잔액-불변성-검증)
- [Part 7 — ILMV (양방향 계층 검증)](#part-7--ilmv-양방향-계층-검증)
- [Part 8 — LPBFT (경량 합의)](#part-8--lpbft-경량-합의)
- [Part 9 — 머클 앵커링 파이프라인](#part-9--머클-앵커링-파이프라인)
- [Part 10 — P1~P6 감사 원칙](#part-10--p1p6-감사-원칙)
- [Part 11 — 3계층 동기화 구조](#part-11--3계층-동기화-구조)
- [Part 12 — 고팡 시스템과의 통합](#part-12--고팡-시스템과의-통합)
- [Part 13 — 구현 현황 및 로드맵](#part-13--구현-현황-및-로드맵)

---

## Part 1 — 개요 및 설계 철학

### 1.1 PDV·OpenHash가 중요한 이유

고팡의 모든 거래·대화·행정 기록은 두 가지 핵심 질문에 답해야 합니다.

```
질문 1: 이 데이터는 위변조되지 않았는가?
  → OpenHash Hash Chain + 머클 앵커링으로 증명

질문 2: 이 데이터의 주인은 누구이며 언제 무엇을 했는가?
  → PDV 6하원칙(6W) 기록으로 증명
```

이 두 질문에 답하지 못하면 고팡의 어떤 거래도, 어떤 AI 판단도, 어떤 법적 증거도 신뢰할 수 없습니다. PDV와 OpenHash는 고팡의 **신뢰 인프라**입니다.

### 1.2 전체 아키텍처 개요

```
사용자 행동 (결제·대화·민원·학습)
         ↓
PDV 6W 기록 (누가·언제·어디서·무엇을·어떻게·왜)
         ↓
Hash Chain 생성 (IDB local_hash → pdv_log.chain_local_hash)
         ↓
PLSM 계층 선택 (L1~L4 확률적 분산)
         ↓
L1 PocketBase 블록 기록 (block_hash → l1_ledger)
         ↓
머클 트리 앵커링 (10분 Cron → merkle_anchors)
         ↓
P1~P6 감사 View 모니터링 (위반 = 0 유지)
```

### 1.3 고팡에서 OpenHash가 담당하는 역할

| 역할 | 담당 모듈 | 현황 |
|------|-----------|------|
| 거래 무결성 | fs_ledger + l1_ledger | ✅ T01~T10 |
| PDV 무결성 | pdv_log + Hash Chain | ✅ T05~T06 |
| 잔액 불변성 | BIVM + sigma_delta View | ✅ T07 |
| 감사 추적 | P1~P6 View | ✅ T10 |
| 타임스탬프 증명 | merkle_anchors | ✅ T10 |
| 계층 분산 | PLSM | ✅ 구현 |
| 양방향 검증 | ILMV | ⚠️ 부분 |
| 비상 합의 | LPBFT | ⚠️ 미완성 |

---

## Part 2 — PDV (Personal Data Vault)

### 2.1 PDV란 무엇인가

PDV는 모든 엔티티(개인·사업자·기관)의 디지털 행동 기록 금고입니다.

```
목적:
  - 본인의 모든 디지털 행동을 본인이 소유·통제
  - 제3자(정부·플랫폼)가 일방적으로 삭제·조작 불가
  - 법적 분쟁 시 자기완결 증거로 활용

구조:
  브라우저 IDB (IndexedDB)  ← 로컬 저장, 빠른 접근
       ↕ 동기화
  Supabase pdv_log          ← 서버 저장, 영구 보존
       ↕ 앵커링
  OpenHash L1 블록체인       ← 불변 타임스탬프
```

### 2.2 PDV 6하원칙 (6W)

모든 PDV 기록은 6하원칙으로 구성됩니다.

```jsonc
{
  "summary_6w": {
    "who":   "34c74aef-a50e-5c1d-be21-eae8e6d72225",  // 행위자 GUID
    "when":  "2026-06-13T09:30:00+09:00",              // 행동 시각 (KST)
    "where": "제주시 한림읍 한림리 123 / 금능반점",      // 물리적 위치
    "what":  "짜장면 1개 주문·결제",                    // 행동 내용
    "how":   "QR 스캔 → GDC 결제 → ED25519 서명",      // 수단·방법
    "why":   "식사 목적"                                // 목적·이유
  }
}
```

### 2.3 PDV 레코드 구조 (pdv_log 테이블)

```sql
pdv_log
  id                UUID PK        -- gen_random_uuid()
  guid              TEXT           -- 행위자 GUID
  source            TEXT           -- 출처 서비스 (market/health/klaw/...)
  type              TEXT           -- 레코드 유형
  report_id         TEXT           -- 보고서 ID
  summary           TEXT           -- 한줄 요약
  summary_6w        TEXT           -- JSON: {who,when,where,what,how,why}
  session_id        UUID UNIQUE    -- 중복 INSERT 차단 기준
  chain_height      INTEGER        -- IDB hash_chain 높이
  chain_local_hash  TEXT           -- IDB local_hash (l1_ledger.user_hash와 일치 필수)
  block_hash        TEXT           -- L1 블록 해시
  openhash_anchored BOOLEAN        -- 머클 앵커링 완료 여부
  reporter_svc      TEXT           -- 기록 주체 서비스
  via_worker        BOOLEAN        -- Worker 경유 여부
  risk_level        TEXT           -- low | medium | high
  created_at        TIMESTAMPTZ
```

### 2.4 PDV Hash Chain (IDB 로컬)

```javascript
// IDB hash_chain 구조
// 각 항목: { height, local_hash, prev_hash, session_id, ts }

// local_hash 계산:
// H_u(i) = SHA-256(H_u(i-1) || session_id || chain_height || tx_data)

async function buildLocalHash(prevHash, sessionId, height, txData) {
  const input = [prevHash, sessionId, String(height), JSON.stringify(txData)].join('||');
  return await sha256hex(input);
}

// 불변 조건:
// IDB hash_chain[N].local_hash
//   = pdv_log.chain_local_hash (chain_height = N)
//   = l1_ledger.user_hash      (PATCH 교정 후)
```

### 2.5 PDV 기록 INSERT 필수 규칙

```javascript
// Worker _recordPDV() 핵심 헤더
fetch(`${SUPABASE_URL}/rest/v1/pdv_log`, {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'apikey': SUPABASE_KEY,
    'Authorization': `Bearer ${SUPABASE_KEY}`,
    'Prefer': 'resolution=ignore-duplicates'  // ← T09 중복 방지 필수
  },
  body: JSON.stringify(entry)
})
```

### 2.6 PDV 3개 기록 경로 (중복 방지)

```
경로 1: Worker /biz/order → _recordOrderPdv()
        reporter_svc 기반 중복 확인 → 유지

경로 2: gopang-app.js GWP_DONE → _recordPDV()
        resolution=ignore-duplicates 헤더 필수

경로 3: market/webapp.html → gwpHandler recordPDV()
        reporter_svc 있으면 Worker 스킵

session_id UNIQUE 인덱스가 DB 레벨 최종 방어선
```

### 2.7 PDV 데이터 주권 원칙

```
소유권:   데이터는 guid 소유자에게 귀속
열람권:   본인 + 권한자(수사기관 영장 시)
삭제권:   결제 관련·긴급 기록은 삭제 불가
          → 무결성 보장을 위한 불변성 원칙
이동권:   본인 요청 시 전체 PDV 데이터 export 가능 (v2.0)
암호화:   민감 PDV (건강·법률) AES-256-GCM 추가 암호화
```

---

## Part 3 — OpenHash 5계층 구조

### 3.1 OpenHash란 무엇인가

OpenHash는 중앙화된 블록체인의 에너지 낭비와 느린 처리 속도를 해결하기 위해 설계된 **확률적 계층 분산 원장** 시스템입니다.

```
기존 블록체인:     모든 노드가 모든 거래를 기록 → 에너지 낭비
OpenHash:          거래별로 적합한 계층에만 기록 → 98.5% 에너지 절감
```

### 3.2 5계층 구조

```
L5 ── 최상위 앵커 계층
│     역할: 머클 루트 최종 앵커, 전체 시스템 신뢰 기준
│     특성: 극히 소수 노드, 최고 신뢰도
│
L4 ── 고중요도 거래 계층
│     역할: 금융 거래, 법적 증거, 의료 기록
│     PLSM 선택 확률: 8% (저중요도 기준)
│
L3 ── 중간 감사 계층
│     역할: 서비스 이용 기록, 교육 이력
│     PLSM 선택 확률: 12%
│
L2 ── 일반 거래 계층
│     역할: 일반 상거래, 커뮤니티 활동
│     PLSM 선택 확률: 30%
│
L1 ── 기본 기록 계층 (고팡 현재 구현 계층)
      역할: 모든 거래의 기본 앵커링
      PLSM 선택 확률: 50%
      현재: PocketBase L1 노드 (Oracle Cloud)
```

### 3.3 고팡 현재 구현 상태

```
현재 (v0.4):
  L1: PocketBase (l1-hanlim.gopang.net) ✅ 운영 중
  L2~L5: 미구현 (v2.0 목표)

Supabase 역할:
  L1 미러 (l1_ledger) — L1 블록을 Supabase에 복사
  PDV 로그 (pdv_log) — 6W 기록
  머클 앵커 (merkle_anchors) — 머클 루트 저장

실제 블록체인 앵커링 목표 (v2.0):
  L1 → L2 → L3 → L4 → L5 순차 전파
  각 계층별 독립 노드 운영
```

---

## Part 4 — PLSM (확률적 계층 선택)

### 4.1 PLSM이란

PLSM(Probabilistic Layer Selection Module)은 거래의 중요도와 최하위 공통 계층(LCAT)을 기준으로 어느 계층에 기록할지 확률적으로 결정합니다.

```
합의 없이 거래를 처리:
  기존 PBFT:  모든 노드 합의 → 느림
  PLSM:       확률로 계층 결정 → 빠름, 에너지 절약
  비상 시:    LPBFT 합의 발동 (Part 8)
```

### 4.2 계층 선택 확률 분포

```
LCAT = L1, 저중요도(일반 대화·상거래):
  L1: 50%  L2: 30%  L3: 12%  L4: 8%

LCAT = L1, 고중요도(금융·법률·의료):
  L1: 10%  L2: 20%  L3: 30%  L4: 40%

LCAT = L2 이상:
  LCAT 미만 계층 제외 후 재분배
```

### 4.3 PLSM 알고리즘

```javascript
function selectLayer(hashHex, importance = 'low', lcat = 'L1') {
  // SHA-256 이중 해싱 후 mod 1000
  const r = parseInt(hashHex.slice(0, 8), 16) % 1000;

  // 저중요도, LCAT=L1 기준
  const thresholds = {
    low:  [500, 800, 920, 1000],  // L1:50% L2:30% L3:12% L4:8%
    high: [100, 300, 600, 1000],  // L1:10% L2:20% L3:30% L4:40%
  };

  const t = thresholds[importance];
  if (r < t[0]) return 'L1';
  if (r < t[1]) return 'L2';
  if (r < t[2]) return 'L3';
  return 'L4';
}

// 검증 결과 (n=30, 저중요도):
// χ² = 3.27 < 7.815 (자유도 3, 유의수준 0.05) → 이론 분포와 일치 ✅
```

### 4.4 중요도 판단 기준

| 거래 유형 | 중요도 | LCAT |
|-----------|--------|------|
| 일반 상거래 (< ₮100,000) | low | L1 |
| 고액 거래 (≥ ₮100,000) | high | L1 |
| 법률 기록 (K-Law) | high | L2 |
| 의료 기록 (K-Health) | high | L2 |
| 긴급 기록 (K-119) | high | L2 |
| 교육 기록 (K-School) | low | L1 |
| 커뮤니티 게시글 | low | L1 |
| AI 대화 기록 | low | L1 |

---

## Part 5 — Hash Chain 생성·검증

### 5.1 3계층 Hash Chain 구조

```
계층 1 — IDB local_hash (클라이언트)
  H_u(i) = SHA-256(H_u(i-1) || session_id || height || tx_data)
  저장: 브라우저 IndexedDB

계층 2 — pdv_log.chain_local_hash (Supabase)
  = IDB hash_chain[i].local_hash (반드시 일치)
  저장: Supabase pdv_log

계층 3 — l1_ledger.user_hash (L1 미러)
  = pdv_log.chain_local_hash (PATCH 교정 후 일치)
  저장: Supabase l1_ledger

불변 조건:
  IDB[N].local_hash = pdv_log[N].chain_local_hash = l1_ledger.user_hash
```

### 5.2 node_hash (Worker Hash Chain)

```javascript
// Worker updateNodeHashChain()
// H_N(i) = SHA-256(H_N(i-1) || H_u(i))
// H_N: 노드 수준 Hash Chain (서버 측)
// H_u: 사용자 수준 Hash Chain (클라이언트 측)

const nodeHash = await sha256hex(prevNodeHash + userHash);
// l1_ledger에 기록
```

### 5.3 user_hash 교정 절차

```
문제: Worker가 l1_ledger에 INSERT할 때는 클라이언트 local_hash를 모름
해결: 결제 완료 후 클라이언트가 PATCH로 교정

_patchL1LedgerUserHash():
  1. IDB에서 current local_hash 조회
  2. l1_ledger WHERE block_hash = 현재 블록 해시
  3. PATCH user_hash = IDB local_hash
  4. pdv_chain_integrity View로 일치 여부 확인
```

### 5.4 Hash Chain 무결성 검증

```sql
-- pdv_chain_integrity View (P3 연속성 감사)
-- pdv_log.chain_local_hash = l1_ledger.user_hash 여부
SELECT pdv_id, pdv_l1_match
FROM pdv_chain_integrity
WHERE pdv_l1_match = FALSE;
-- 기대값: 0건

-- chain_height 연속성 검증 (P2)
SELECT chain_height, COUNT(*) as cnt
FROM pdv_log
GROUP BY chain_height
HAVING COUNT(*) > 1;
-- 기대값: 0건 (동일 height 중복 없음)
```

---

## Part 6 — BIVM (잔액 불변성 검증)

### 6.1 BIVM이란

BIVM(Balance Invariant Verification Module)은 모든 금융 거래에서 **이중 기입 원칙**을 수학적으로 검증합니다.

```
핵심 공식:
  Σ(debit) = Σ(credit)   ← 거래별 BIVM
  Σδ_k = 0               ← 전체 시스템 BIVM

의미:
  누군가의 지출 = 누군가의 수입
  돈은 생성되거나 소멸하지 않음
  위변조 시 이 등식이 깨짐 → 즉시 탐지
```

### 6.2 고팡 거래 BIVM 적용

```
1건 거래 = fs_ledger 3행:
  행1: buyer    debit  ₮15,000  (구매자 지출)
  행2: seller   credit ₮14,550  (판매자 수입)
  행3: platform credit ₮450     (수수료 3%)

BIVM 검증:
  Σdebit  = 15,000
  Σcredit = 14,550 + 450 = 15,000
  15,000 = 15,000 → ✅

위반 예시:
  행2 seller credit = ₮14,000 (₮550 누락)
  Σcredit = 14,000 + 450 = 14,450 ≠ 15,000 → 즉시 탐지
```

### 6.3 계정 과목 공식

```
bs-cash     = Σcredit - Σdebit       (순변동분, 현재 잔액)
pl-purchase = Σdebit  (양수 누적)    (총 구매 지출액)
pl-revenue  = Σcredit (양수 누적)    (총 판매 수입액)

주의:
  pl-purchase = cur + amount (양수 누적)
  pl-purchase ≠ cur - amount (음수 누적 오류 — T08 수정됨)
  bs-cash ≠ 절대잔액 (순변동분임)
```

### 6.4 BIVM 검증 쿼리 (P6 감사)

```sql
-- sigma_delta_by_node View (Σδ=0 검증)
SELECT node_id, sigma_delta
FROM sigma_delta_by_node
WHERE sigma_delta > 1;  -- 부동소수점 허용 오차 1
-- 기대값: 0건

-- ktax_balance_anomalies View (잔액 불일치 감지)
SELECT guid, anomaly_type, ledger_bs_cash, profile_bs_cash
FROM ktax_balance_anomalies;
-- 기대값: 0건

-- 거래별 BIVM 검증
SELECT tx_id,
  SUM(CASE WHEN direction='debit'  THEN amount ELSE 0 END) AS total_debit,
  SUM(CASE WHEN direction='credit' THEN amount ELSE 0 END) AS total_credit,
  ABS(SUM(CASE WHEN direction='debit' THEN amount ELSE -amount END)) AS delta
FROM fs_ledger
GROUP BY tx_id
HAVING ABS(SUM(CASE WHEN direction='debit' THEN amount ELSE -amount END)) > 1;
-- 기대값: 0건
```

### 6.5 BMI (잔액 매핑 무결성)

```
BMI = 각 계층별 머클 트리에 잔액 스냅샷 저장
→ 주기적으로 불변 계층의 머클 루트 비교
→ 무단 잔액 변경 탐지

현재 구현:
  user_profiles.extra.fs (잔액 스냅샷)
  gdc_settle_ledger() (집계 후 스냅샷 갱신)
  ktax_balance_anomalies (스냅샷 vs 원장 비교)

v2.0 목표:
  각 L1~L4 계층별 머클 루트로 BMI 검증
```

---

## Part 7 — ILMV (양방향 계층 검증)

### 7.1 ILMV란

ILMV(Inter-Layer Mutual Verification)는 인접하지 않은 계층 간의 교차 검증 시스템입니다.

```
하향 감사 (Downward Audit): L5 → L4 → L3 → L2 → L1
  상위 계층이 하위 계층의 기록을 주기적으로 감사
  L2→L1: 100% 완전 스트리밍
  L3→L2: 샘플링 기반 (10%)

상향 모니터링 (Upward Monitoring): L1 → L2 → L3 → L4 → L5
  하위 계층이 임계값 초과 시 상위 계층에 알림
  이상 거래 탐지, 처리량 급증 알림
```

### 7.2 하향 감사 항목 (12개)

```
L2→L1 감사 (6개):
  A1. block_hash 연속성 (이전 해시 체인 연결)
  A2. 타임스탬프 단조 증가 (이전 블록보다 늦어야 함)
  A3. 서명 유효성 (ED25519 공개키 검증)
  A4. BIVM Σδ=0 (거래별 차변=대변)
  A5. 잔액 음수 방지 (bs-cash ≥ 0)
  A6. GUID 유효성 (등록된 사용자만)

L3→L2 감사 (6개):
  B1. 머클 루트 일치
  B2. 블록 카운트 연속성
  B3. 이상 거래 패턴 없음
  B4. 중복 tx_id 없음
  B5. 허용된 source 코드만
  B6. 계층 선택 확률 분포 (PLSM χ² 검정)
```

### 7.3 현재 구현 상태 (P1~P6 View)

```sql
-- P1: block_hash 연속성
SELECT COUNT(*) FROM p1_chain_continuity WHERE fail = true;

-- P2: chain_height 연속성
SELECT COUNT(*) FROM p2_chain_height_gap WHERE gap > 1;

-- P3: pdv_log ↔ l1_ledger user_hash 일치
SELECT COUNT(*) FROM p3_pdv_l1_match WHERE match = false;

-- P4: 타임스탬프 단조 증가
SELECT COUNT(*) FROM p4_timestamp_monotonic WHERE fail = true;

-- P5: 잔액 음수 방지
SELECT COUNT(*) FROM p5_balance_negative WHERE fail = true;

-- P6: Σδ=0 (BIVM)
SELECT COUNT(*) FROM sigma_delta_by_node WHERE sigma_delta > 1;

-- T10 전체 통과 기준: 모든 View COUNT = 0
```

---

## Part 8 — LPBFT (경량 합의)

### 8.1 LPBFT란

LPBFT(Lightweight PBFT)는 **비상 상황에서만** 발동하는 최소 침습적 합의 알고리즘입니다.

```
평상시: PLSM으로 합의 없이 빠른 처리
비상시: LPBFT로 5개 조건에서만 합의 수행
목표: 가용성(Availability) 최대화 + 무결성(Integrity) 보장
```

### 8.2 LPBFT 발동 조건 (5개)

```javascript
const EMERGENCY_CONDITIONS = [
  'HASH_CHAIN_BREAK',        // Hash Chain 연속성 파괴
  'BIVM_VIOLATION',          // Σδ ≠ 0 위반
  'NODE_BYZANTINE',          // 비잔틴 노드 탐지 (악의적 응답)
  'NETWORK_PARTITION',       // 네트워크 분리
  'ILMV_THRESHOLD_EXCEEDED', // ILMV 임계값 초과
];
```

### 8.3 LPBFT 비활성화 조건 (4개)

```javascript
const DEACTIVATION_CONDITIONS = [
  'CHAIN_CONTINUITY_RESTORED',   // Hash Chain 복구 완료
  'BIVM_BALANCE_RESTORED',       // 잔액 불변성 복구
  'BYZANTINE_NODE_ISOLATED',     // 비잔틴 노드 격리 완료
  'NETWORK_PARTITION_HEALED',    // 네트워크 복구
];
// 4개 조건 모두 충족 → LPBFT 자동 해제 → PLSM 재개
```

### 8.4 현재 구현 상태

```
구현 완료:
  - LPBFT 발동·비활성화 조건 정의
  - 고팡 Worker의 409 STALE_STATE가 사실상 LPBFT 역할
  - ktax_balance_anomalies > 0 시 결제 중단

미구현 (v2.0):
  - 실제 분산 노드 간 PBFT 프로토콜
  - 비잔틴 노드 탐지 자동화
  - 네트워크 분리 감지
  - 합의 레이턴시 목표: 0.759ms (논문 Table 2)
```

---

## Part 9 — 머클 앵커링 파이프라인

### 9.1 머클 트리란

```
여러 PDV 기록을 하나의 해시 값(머클 루트)으로 요약
→ 머클 루트만 저장해도 개별 기록의 존재 및 무결성 증명 가능
→ 타임스탬프 증거: "이 시각에 이 기록들이 존재했음"
```

### 9.2 머클 트리 계산

```javascript
async function computeMerkleRoot(hashes) {
  if (hashes.length === 0) return null;
  if (hashes.length === 1) return hashes[0];

  let level = [...hashes];
  while (level.length > 1) {
    const next = [];
    for (let i = 0; i < level.length; i += 2) {
      const left  = level[i];
      const right = level[i + 1] ?? left;  // 홀수 개 → 마지막 복제
      next.push(await sha256hex(left + right));
    }
    level = next;
  }
  return level[0];
}
```

### 9.3 앵커링 Cron 파이프라인

```
Cloudflare Cron: */10 * * * * (10분 주기)
  ↓
anchorL1MerkleRoot():
  1. pdv_log WHERE openhash_anchored=false 조회
     (via_worker 조건 없음 — T10 E4 수정)
  2. chain_local_hash 목록 추출
  3. computeMerkleRoot(hashes)
  4. merkle_anchors INSERT:
     { merkle_root, pdv_count, anchored_at, status:'confirmed' }
  5. pdv_log PATCH: openhash_anchored = true
  ↓
결과: 모든 PDV 기록이 10분 내 머클 앵커링 완료
```

### 9.4 머클 무결성 검증 엔드포인트

```
GET /merkle/verify?pdv_id={id}

처리:
  1. pdv_log에서 해당 id 조회 (anchored 여부 확인)
  2. 동일 배치 pdv_log 전체 조회
  3. chain_local_hash 목록으로 머클 루트 재계산
  4. merkle_anchors 저장 루트와 비교

응답:
  {
    "valid": true,
    "pdv_id": "...",
    "merkle_root": "재계산된 루트",
    "stored_root": "저장된 루트",
    "pdv_included": true
  }
```

### 9.5 merkle_anchors 테이블

```sql
merkle_anchors
  id          UUID PK
  merkle_root TEXT NOT NULL     -- SHA-256 머클 루트
  anchored_at TIMESTAMPTZ       -- 앵커링 시각 (타임스탬프 증거)
  block_count INTEGER NOT NULL  -- 포함된 PDV 건수
  pdv_ids     JSONB NOT NULL    -- 포함된 pdv_log.id 배열
  l1_block_hash TEXT            -- L1 앵커 블록 해시
  status      TEXT CHECK        -- pending | confirmed | failed
```

---

## Part 10 — P1~P6 감사 원칙

### 10.1 6개 감사 원칙 개요

T10에서 구현·검증된 OpenHash 6개 감사 원칙.

| 원칙 | 명칭 | 감사 내용 | View |
|------|------|-----------|------|
| P1 | Block Hash 연속성 | 이전 block_hash 체인 연결 | p1_chain_continuity |
| P2 | Chain Height 연속성 | chain_height 갭 없음 | p2_chain_height_gap |
| P3 | PDV-L1 Hash 일치 | chain_local_hash = user_hash | pdv_chain_integrity |
| P4 | 타임스탬프 단조 증가 | 이전 블록보다 늦은 시각 | p4_timestamp_monotonic |
| P5 | 잔액 음수 방지 | bs-cash ≥ 0 | p5_balance_negative |
| P6 | BIVM Σδ=0 | 전체 차변 = 전체 대변 | sigma_delta_by_node |

### 10.2 전체 감사 쿼리 (T10 기준)

```sql
-- P1: block_hash 연속성
SELECT 'P1' AS principle, COUNT(*) AS fail_count
FROM pdv_log p
WHERE p.block_hash NOT LIKE 'bh-%'  -- 테스트 데이터 제외
  AND NOT EXISTS (
    SELECT 1 FROM l1_ledger l
    WHERE l.block_hash = p.block_hash
  );

-- P2: chain_height 연속성
SELECT 'P2' AS principle, COUNT(*) AS fail_count
FROM (
  SELECT chain_height,
    LAG(chain_height) OVER (ORDER BY chain_height) AS prev_height
  FROM pdv_log
  WHERE chain_height IS NOT NULL
) sub
WHERE chain_height - prev_height > 1;

-- P3: PDV-L1 hash 일치
SELECT 'P3' AS principle, COUNT(*) AS fail_count
FROM pdv_log p
JOIN l1_ledger l ON l.block_hash = p.block_hash
WHERE p.chain_local_hash != l.user_hash;

-- P6: BIVM Σδ=0
SELECT 'P6' AS principle, COUNT(*) AS fail_count
FROM sigma_delta_by_node
WHERE sigma_delta > 1;

-- T10 전체 통과: 모든 fail_count = 0
```

### 10.3 자동 모니터링 설정

```
목표: P1~P6 fail_count 상시 0 유지
방법:
  - Cloudflare Cron 10분 주기 → 머클 앵커링 + P6 검증
  - Supabase pg_cron (v2.0): 1시간 주기 P1~P5 감사
  - 이상 발생 시: security_event INSERT + 관리자 알림
```

---

## Part 11 — 3계층 동기화 구조

### 11.1 거래 완료 후 전체 데이터 흐름 (8단계)

```
[거래 발생]
  소비자 pay.html → [서명하여 결제] → Worker /biz/order

[서버 처리]
  ① fs_ledger 3행 INSERT (market_purchase RPC)
     buyer debit / seller credit / platform credit
     → BIVM: Σdebit = Σcredit 검증

  ② l1_ledger INSERT
     block_hash, user_hash(임시), node_hash, balance_claimed
     Worker updateNodeHashChain()

  ③ buyer_claim 생성
     { direction, amount, expires_at: +7일 }
     → GWP_DONE에 포함하여 클라이언트 전달

[클라이언트 처리]
  ④ IDB financial_state 갱신 (redeemClaim)
     bs-cash 차감, pl-purchase 양수 누적

  ⑤ l1_ledger.user_hash ← IDB local_hash PATCH 교정
     _patchL1LedgerUserHash()

  ⑥ pdv_log INSERT
     6W 기록 + chain_local_hash + chain_height
     Prefer: resolution=ignore-duplicates

[자동화]
  ⑦ GDC gdc_settle_ledger()
     fs_ledger 집계 → user_profiles.extra.fs UPDATE

  ⑧ Cron 10분
     anchorL1MerkleRoot()
     → pdv_log 배치 → merkle_anchors INSERT
```

### 11.2 3계층 불변 조건

```
조건 1 — STALE_STATE 방지:
  IDB financial_state.block_hash = L1 blocks 최신 content_hash

조건 2 — PDV Hash Chain 3계층 일치:
  IDB hash_chain[N].local_hash
    = pdv_log.chain_local_hash (chain_height = N)
    = l1_ledger.user_hash       (PATCH 교정 후)

조건 3 — BIVM Σδ=0:
  buyer debit = seller credit + platform credit (per tx_id)

조건 4 — 잔액 스냅샷 일치:
  user_profiles.extra.fs.bs-cash
    = gdc_settle_ledger() 집계값
    = ktax_balance_anomalies 건수 0
```

### 11.3 오류 진단 및 즉각 조치

| 증상 | 원인 | 조치 |
|------|------|------|
| ktax_balance_anomalies > 0 | extra.fs 불일치 | gdc_settle_ledger() 재실행 |
| 409 STALE_STATE | IDB block_hash ≠ L1 | IDB block_hash 확인 후 동기화 |
| pdv_l1_match = false | user_hash 미교정 | _patchL1LedgerUserHash() 재실행 |
| 23514 오류 | source = 'kmarket' | source = 'market' 로 수정 |
| 머클 앵커링 안 됨 | Cron 미등록·via_worker 조건 | Cloudflare Triggers 확인 |
| P1~P6 fail_count > 0 | Hash Chain 파괴 | LPBFT 발동 조건 확인 |

---

## Part 12 — 고팡 시스템과의 통합

### 12.1 서비스별 PDV 기록 유형

| 서비스 | source 코드 | 기록 내용 | 중요도 |
|--------|-------------|-----------|--------|
| K-Market | market | 상거래 결제, 주문, 리뷰 | low~high |
| K-Law | klaw (v2.0) | 법률 상담, 증거 기록 | high |
| K-Health | health | 의료 상담, 처방 | high |
| K-119 | kemergency | 긴급 신고, 출동 기록 | high |
| K-Tax | tax | 세무 기록 | high |
| K-School | school (v2.0) | 학습 이력 | low |
| K-Democracy | democracy | 투표, 청원 | high |
| K-Police | kpolice (v2.0) | 치안 기록 | high |
| Community | manual | 커뮤니티 활동 | low |

### 12.2 Profile 2.0과의 연동

```
모든 엔티티(개인·사업자·기관)의 PDV 기록:
  → guid 기준으로 pdv_log에 누적
  → 본인만 전체 열람 가능 (PRIVATE 계층)
  → 법적 분쟁 시 6W 기록이 증거

AI 비서 소통:
  → 대화 세션별 pdv_log 기록
  → session_id로 중복 방지
  → 에스컬레이션 기록 포함

AI↔AI 에이전트:
  → agent_sessions의 최종 결정을 pdv_log에 기록
  → human_approved = true 시에만 기록
```

### 12.3 사용자 신뢰 등급과 OpenHash

```
trust_level 0 (미인증):
  pdv_log 기록 가능, 머클 앵커링 대상
  단, 법적 증거 효력 제한

trust_level 1 (전화인증):
  전화번호 소유 증명 → GUID 신뢰도 향상
  PDV 기록 + OpenHash 앵커링 = 법적 증거 효력

trust_level 2 (사업자인증):
  사업자등록번호 검증 → 고액 거래 허용
  PDV + OpenHash = 세무·법률 증거

trust_level 3 (공공기관):
  정부24 검증 → 최고 신뢰도
  PDV + OpenHash = 공문서 수준 증거
```

---

## Part 13 — 구현 현황 및 로드맵

### 13.1 현재 구현 현황 (v0.4.0-T10)

| 모듈 | 구현 | TRL | 비고 |
|------|------|-----|------|
| PDV 6W 기록 | ✅ 완료 | 5 | pdv_log 43개 테이블 |
| Hash Chain (IDB) | ✅ 완료 | 5 | local_hash 3계층 일치 |
| PLSM | ✅ 완료 | 5 | χ²=3.27 < 7.815 검증 |
| L1 앵커링 | ✅ 완료 | 5 | PocketBase Oracle Cloud |
| BIVM (고팡) | ✅ 완료 | 5 | fs_ledger Σδ=0 검증 |
| 머클 앵커링 | ✅ 완료 | 5 | 10분 Cron |
| P1~P6 감사 | ✅ 완료 | 5 | T10 fail_count=0 |
| ILMV (완전) | ⚠️ 부분 | 3 | 12항목 중 일부 |
| LPBFT | ⚠️ 부분 | 3 | 조건 정의, 프로토콜 미구현 |
| L2~L5 계층 | ❌ 미구현 | 2 | v2.0 목표 |
| BMI (완전) | ❌ 미구현 | 2 | v2.0 목표 |

### 13.2 v1.0 → v2.0 로드맵

| 버전 | 목표 | OpenHash 목표 |
|------|------|---------------|
| v0.4 현재 | K-Market T01~T10 | L1 + BIVM + 머클 |
| v1.0 2026-Q3 | 한림읍 파일럿 | P1~P6 자동 모니터링 |
| v1.1 2026-Q4 | 소비자 1,000명 | ILMV 12항목 완성 |
| v2.0 2027-Q3 | 10만 엔티티 | L2~L4 계층 + LPBFT |

### 13.3 성능 목표 (v2.0)

| 지표 | v1.0 (현재) | v2.0 목표 |
|------|-------------|-----------|
| PDV 기록 지연 | ~100ms | < 50ms |
| 머클 앵커링 | 10분 | 5분 |
| P1~P6 감사 | 수동 쿼리 | 1시간 자동 |
| LPBFT 합의 | 미구현 | 0.759ms |
| TPS | ~100 | 1,000+ |
| 에너지 절감 | — | 98.5% (블록체인 대비) |

---

## 부록 — PDV·OpenHash 핵심 체크리스트

```
PDV 기록
  □ session_id UNIQUE 인덱스 활성화 확인
  □ resolution=ignore-duplicates 헤더 모든 경로에 적용
  □ summary_6w에 who/when/where/what/how/why 6개 필드 모두 포함
  □ via_worker=true 로 Worker 경유 기록 구분

Hash Chain
  □ IDB local_hash = pdv_log.chain_local_hash 일치 확인
  □ _patchL1LedgerUserHash() 결제 완료 후 반드시 실행
  □ chain_height 연속성 (갭 없음) 확인

BIVM
  □ fs_ledger 3행 원자 INSERT (market_purchase RPC)
  □ Σdebit = Σcredit per tx_id 검증
  □ pl-purchase = cur + amount (양수 누적) 확인
  □ ktax_balance_anomalies = 0 유지

머클 앵커링
  □ Cron */10 * * * * 등록 확인
  □ anchorL1MerkleRoot() via_worker 조건 없이 실행
  □ merkle_anchors status='confirmed' 확인
  □ /merkle/verify → valid:true 확인

P1~P6 감사
  □ P1~P6 모든 fail_count = 0
  □ sigma_delta_by_node COUNT = 0
  □ pdv_chain_integrity pdv_l1_match=false COUNT = 0
```

---

*GOPANG-PDV-OPENHASH-v1.0 · 초안*  
*AI City Inc. · 2026-06-13*  
*OpenHash SCI 논문 v2.2 + T01~T10 검증 결과 기반*
