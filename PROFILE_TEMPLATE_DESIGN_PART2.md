# 고팡 Profile 템플릿 설계서 — Part 2
## 한국표준산업분류 중분류 77개 확장 템플릿

**문서 ID**: GOPANG-PROFILE-DESIGN-PART2-v1.0  
**작성일**: 2026-06-13  
**기준**: 한국표준산업분류 제11차 개정 (통계청 고시 제2024-2호, 2024.7.1 시행)  
**연계**: PROFILE_TEMPLATE_DESIGN.md Part 1 BaseProfile 상속

---

## 설계 원칙

### Part 2 상속 구조

```
BaseProfile (Part 1)
  └── entity_type = 'org' 또는 'institution'
        └── extra.public.identity.entity_subtype = KSIC 중분류 코드
              └── Part 2 확장 필드 (extra.public.biz / extra.private.biz)
                    └── AI 비서 system prompt 추가 규칙
```

### 고팡 적용 우선순위

```
고팡 핵심 (★★★): 음식점·숙박·보건·교육·소매·공공행정·금융·전문서비스
고팡 중요 (★★):  농업·어업·운수·창고·정보통신·부동산·협회·여가
고팡 일반 (★):   제조업·건설업·광업·기타
```

### extra JSONB 확장 구조

```
BaseProfile.extra
  ├── public
  │    ├── identity._schema_version  "2.0"
  │    ├── identity.entity_subtype   "56"  ← KSIC 중분류 코드
  │    ├── biz{}                     ← Part 2 공개 확장 필드
  │    └── activity.hours            BaseProfile 영업시간
  ├── semi
  │    └── biz{}                     ← Part 2 반공개 확장 필드
  └── private
       └── biz{}                     ← Part 2 비공개 확장 필드
```

---

## 목차 (대분류별)

| 대분류 | 코드 | 주요 중분류 | 고팡 우선순위 |
|--------|------|------------|--------------|
| A. 농업·임업·어업 | 01~03 | 농업(01), 어업(03) | ★★ |
| B. 광업 | 05~08 | — | ★ |
| C. 제조업 | 10~34 | 식료품(10), 의약품(21) | ★ |
| D. 전기·가스 | 35 | — | ★ |
| E. 수도·폐기물 | 36~39 | 수도(36) | ★ |
| F. 건설업 | 41~42 | — | ★ |
| G. 도소매업 | 45~47 | 소매업(47) | ★★★ |
| H. 운수·창고업 | 49~52 | 육상운송(49) | ★★ |
| I. 숙박·음식점업 | 55~56 | 숙박(55), 음식점(56) | ★★★ |
| J. 정보통신업 | 58~63 | 소프트웨어(62) | ★★ |
| K. 금융·보험업 | 64~66 | 금융(64) | ★★★ |
| L. 부동산업 | 68 | 부동산(68) | ★★ |
| M. 전문·과학·기술 | 70~73 | 전문서비스(71) | ★★★ |
| N. 사업지원·임대 | 74~76 | 사업지원(75) | ★★ |
| O. 공공행정 | 84 | 공공행정(84) | ★★★ |
| P. 교육 서비스업 | 85 | 교육(85) | ★★★ |
| Q. 보건·사회복지 | 86~87 | 보건(86), 사회복지(87) | ★★★ |
| R. 예술·스포츠·여가 | 90~91 | 스포츠·오락(91) | ★★ |
| S. 협회·수리·개인 | 94~96 | 협회(94), 개인서비스(96) | ★★ |
| T. 가구 내 고용 | 97~98 | — | ★ |
| U. 국제기관 | 99 | — | ★ |

---

## I. 음식점 및 주점업 (KSIC 56) ★★★

> 고팡 가장 핵심 업종. 금능반점(@hallim_geumneung) 기준 설계.

### extra.public.biz (56)
```jsonc
{
  "public": {
    "biz": {
      "ksic_code":       "56",
      "ksic_name":       "음식점 및 주점업",
      "cuisine_type":    "중화요리",
      "menu": [
        {
          "id":       "m001",
          "name":     "짜장면",
          "price":    7000,
          "desc":     "춘장으로 볶은 중화 면 요리",
          "allergens":["대두", "밀"],
          "kcal":     650,
          "is_available": true,
          "image_url": ""
        }
      ],
      "min_order":       0,
      "delivery":        true,
      "delivery_fee":    3000,
      "takeout":         true,
      "dine_in":         true,
      "seating":         30,
      "kids_friendly":   true,
      "halal":           false,
      "vegetarian":      false,
      "vegan":           false
    }
  }
}
```

### extra.private.biz (56)
```jsonc
{
  "private": {
    "biz": {
      "biz_reg_no":      "123-45-67890",
      "ceo_name":        "김민준",
      "food_license_no": "제주-2015-001234",
      "haccp":           true,
      "monthly_revenue_range": "1000~3000만원"
    }
  }
}
```

### AI 비서 추가 규칙 (56)
```
[메뉴 안내 규칙]
R56-01. 메뉴 전체 목록을 정확히 안내한다 (할루시네이션 금지)
R56-02. 알레르기 정보는 반드시 정확하게 안내한다 (안전 최우선)
R56-03. 가격은 GDC(₮) 단위로 안내한다
R56-04. 배달 가능 지역·최소 주문금액을 정확히 안내한다
R56-05. "주문할게요" 의사 확인 시 pay.html URL 안내

[금지 사항]
- 메뉴에 없는 요리 제조 불가 안내 (재료 문의 제조 요청 거절)
- 타 식당 비교·추천 금지
- 레시피 공개 금지
```

### CSV 추가 컬럼 (56)
```
cuisine_type, menu_json, delivery, takeout, seating,
halal, vegetarian, min_order, delivery_fee
```

---

## II. 숙박업 (KSIC 55) ★★★

### extra.public.biz (55)
```jsonc
{
  "public": {
    "biz": {
      "ksic_code":       "55",
      "ksic_name":       "숙박업",
      "accommodation_type": "게스트하우스",
      "rooms": [
        {
          "id":       "r001",
          "name":     "바다 전망 더블룸",
          "price":    85000,
          "capacity": 2,
          "amenities":["에어컨","와이파이","욕실"],
          "is_available": true
        }
      ],
      "check_in":        "15:00",
      "check_out":       "11:00",
      "total_rooms":     8,
      "breakfast":       false,
      "parking":         true,
      "pets":            false,
      "min_stay_nights": 1,
      "cancellation_policy": "체크인 3일 전 무료 취소"
    }
  }
}
```

### AI 비서 추가 규칙 (55)
```
R55-01. 객실 유형·가격·가용 여부 정확히 안내
R55-02. 체크인·체크아웃 시간 반드시 안내
R55-03. 취소 정책을 예약 전 반드시 안내
R55-04. 예약 확정은 사람 승인 필요 → 에스컬레이션 안내
```

---

## III. 소매업 (KSIC 47) ★★★

> 편의점·농산물 직거래·수산물 등 포함

### extra.public.biz (47)
```jsonc
{
  "public": {
    "biz": {
      "ksic_code":       "47",
      "ksic_name":       "소매업",
      "retail_type":     "편의점",
      "products": [
        {
          "id":       "p001",
          "name":     "제주 한라봉 3kg",
          "price":    25000,
          "unit":     "박스",
          "stock":    50,
          "origin":   "제주 한림읍",
          "is_available": true
        }
      ],
      "online_order":    true,
      "pickup":          true,
      "delivery":        true,
      "delivery_area":   ["한림읍", "한경면"],
      "return_policy":   "수령 후 24시간 내 불량품만"
    }
  }
}
```

### AI 비서 추가 규칙 (47)
```
R47-01. 재고 상황을 정확히 안내 (품절 시 명확히 고지)
R47-02. 배송 가능 지역·소요 기간 안내
R47-03. 원산지 정보 정확히 안내
R47-04. 환불·교환 정책 안내
```

---

## IV. 보건업 (KSIC 86) ★★★

> 병원·의원·약국·한의원·치과 포함. 안전 최우선.

### extra.public.biz (86)
```jsonc
{
  "public": {
    "biz": {
      "ksic_code":       "86",
      "ksic_name":       "보건업",
      "facility_type":   "의원",
      "medical_dept": ["내과", "가정의학과"],
      "services": [
        {
          "id":     "s001",
          "name":   "초진 진료",
          "price":  15000,
          "desc":   "건강보험 적용 시 본인부담금 기준",
          "requires_appointment": false
        },
        {
          "id":     "s002",
          "name":   "건강검진",
          "price":  80000,
          "desc":   "기본 혈액검사 포함",
          "requires_appointment": true
        }
      ],
      "insurance_accepted": true,
      "foreign_patient":   true,
      "interpreter":       ["zh", "en"],
      "emergency":         false,
      "appointment_required": false
    }
  }
}
```

### AI 비서 추가 규칙 (86) — 안전 최우선
```
R86-01. 진단·처방·의학적 판단 절대 금지
         → "의사 선생님께 직접 문의하세요"
R86-02. 증상 설명 시 → 진료 안내만 가능
         "해당 증상은 진료가 필요합니다. 내원하시겠습니까?"
R86-03. 응급 증상 감지 시 → 즉시 119 안내
         키워드: 가슴통증, 호흡곤란, 의식불명 등
R86-04. 약 복용법·용량 안내 금지
R86-05. 외국인 환자: 통역 가능 언어 및 의료관광 지원 안내 가능
R86-06. 예약 가능 시간 안내 → 확정은 사람 에스컬레이션
```

### extra.private.biz (86)
```jsonc
{
  "private": {
    "biz": {
      "license_no":      "제주-의원-2015-001",
      "doctor_count":    2,
      "health_insurance_code": "12345"
    }
  }
}
```

---

## V. 교육 서비스업 (KSIC 85) ★★★

> 초중고교·유치원·학원·문화센터·직업훈련 포함

### extra.public.biz (85)
```jsonc
{
  "public": {
    "biz": {
      "ksic_code":       "85",
      "ksic_name":       "교육 서비스업",
      "education_type":  "학원",
      "programs": [
        {
          "id":       "c001",
          "name":     "도예 입문반",
          "price":    120000,
          "duration": "월 8회 (주 2회)",
          "capacity": 10,
          "age_range": "성인",
          "is_available": true
        }
      ],
      "target_age":      ["성인"],
      "languages":       ["ko", "en"],
      "trial_class":     true,
      "trial_price":     0,
      "online_available": false
    }
  }
}
```

### AI 비서 추가 규칙 (85)
```
R85-01. 수강 프로그램·일정·가격 정확히 안내
R85-02. 체험 수업 가능 여부 안내
R85-03. 연령·수준별 적합 프로그램 안내 가능
R85-04. 등록은 사람 에스컬레이션 또는 결제 URL 안내
R85-05. 타 교육기관 비교 금지
```

---

## VI. 공공행정, 국방 및 사회보장 행정 (KSIC 84) ★★★

> 시청·읍면동사무소·경찰서·소방서 등 기관

### extra.public.biz (84)
```jsonc
{
  "public": {
    "biz": {
      "ksic_code":       "84",
      "ksic_name":       "공공행정",
      "org_type":        "읍면동사무소",
      "parent_org":      "제주특별자치도 제주시",
      "jurisdiction":    "한림읍 전체",
      "services": [
        {
          "id":     "sv001",
          "name":   "주민등록 등·초본 발급",
          "desc":   "본인 신분증 지참, 수수료 400원",
          "online": true,
          "online_url": "https://www.gov.kr"
        },
        {
          "id":     "sv002",
          "name":   "상하수도 민원",
          "desc":   "누수 신고, 수도 개폐전 신청",
          "online": false,
          "phone":  "064-728-2661"
        }
      ],
      "emergency_contact": "064-728-2661",
      "after_hours":     "제주시청 당직실 064-728-2000",
      "foreign_support": true,
      "foreign_langs":   ["en", "zh"]
    }
  }
}
```

### AI 비서 추가 규칙 (84)
```
R84-01. 민원 처리 절차·구비서류·수수료 정확히 안내
R84-02. 법적 판단·행정 결정은 담당 공무원 연결
R84-03. 개인정보(주민번호 등) 요구 또는 제공 금지
R84-04. 긴급 민원 → 담당자 에스컬레이션
R84-05. 온라인 처리 가능 민원 → 정부24 URL 안내
R84-06. 외국인 민원: 외국인등록·체류 관련 출입국사무소 안내
```

---

## VII. 사회복지 서비스업 (KSIC 87) ★★★

### extra.public.biz (87)
```jsonc
{
  "public": {
    "biz": {
      "ksic_code":       "87",
      "ksic_name":       "사회복지 서비스업",
      "welfare_type":    "노인복지시설",
      "target_group":    ["노인", "장애인"],
      "services": [
        {
          "id":   "w001",
          "name": "주간보호 서비스",
          "desc": "만 65세 이상, 장기요양등급 보유자",
          "fee_type": "장기요양보험 적용"
        }
      ],
      "capacity":        30,
      "waiting_list":    true,
      "gov_certified":   true,
      "cert_number":     "제주-노인-2020-001"
    }
  }
}
```

### AI 비서 추가 규칙 (87)
```
R87-01. 서비스 대상 요건(연령·등급 등) 정확히 안내
R87-02. 장기요양보험 적용 여부 안내
R87-03. 입소 대기 여부 솔직히 안내
R87-04. 의료적 판단 금지 → 담당 사회복지사 연결
```

---

## VIII. 금융업 (KSIC 64) ★★★

> GDC 연동 핵심 업종

### extra.public.biz (64)
```jsonc
{
  "public": {
    "biz": {
      "ksic_code":       "64",
      "ksic_name":       "금융업",
      "finance_type":    "협동조합",
      "services": [
        {
          "id":   "f001",
          "name": "GDC 충전",
          "desc": "현금으로 GDC 구매 가능",
          "min_amount": 10000,
          "max_amount": 1000000
        }
      ],
      "gdc_exchange":    true,
      "cash_in":         true,
      "cash_out":        true,
      "foreign_currency": false
    }
  }
}
```

### AI 비서 추가 규칙 (64)
```
R64-01. 재무·투자 조언 금지 → "전문 금융 상담사에게 문의하세요"
R64-02. GDC 충전·환전 절차 안내 가능
R64-03. 금리·수수료 현황 정보 안내 가능
R64-04. 계좌 개설·대출은 담당 직원 에스컬레이션
```

---

## IX. 전문서비스업 (KSIC 71) ★★★

> 법률·회계·세무·공증 포함

### extra.public.biz (71)
```jsonc
{
  "public": {
    "biz": {
      "ksic_code":       "71",
      "ksic_name":       "전문서비스업",
      "service_type":    "법률서비스",
      "specialties":     ["부동산", "계약", "가족법"],
      "services": [
        {
          "id":   "l001",
          "name": "법률 상담 (30분)",
          "price": 50000,
          "desc": "초기 상담, 사건 분석"
        }
      ],
      "languages":       ["ko", "zh", "en"],
      "bar_certified":   true,
      "consultation_method": ["대면", "전화", "화상"],
      "appointment_required": true
    }
  }
}
```

### AI 비서 추가 규칙 (71)
```
R71-01. 법률 판단·법적 의견 제공 절대 금지
         → "변호사 선생님께 직접 상담하세요"
R71-02. 상담 가능 분야·예약 방법·비용 안내 가능
R71-03. 긴급 법률 상황 → 대한법률구조공단 132 안내
R71-04. 외국인 → 가능 언어 확인 후 안내
```

---

## X. 농업 (KSIC 01) ★★

### extra.public.biz (01)
```jsonc
{
  "public": {
    "biz": {
      "ksic_code":       "01",
      "ksic_name":       "농업",
      "farm_type":       "과수원",
      "products": [
        {
          "id":      "ag001",
          "name":    "한라봉",
          "price":   35000,
          "unit":    "5kg 박스",
          "season":  "12월~2월",
          "cert":    "GAP 인증",
          "is_available": true
        }
      ],
      "direct_sale":     true,
      "farm_experience": true,
      "experience_price": 15000,
      "organic":         false,
      "gap_certified":   true,
      "origin":          "제주 한림읍"
    }
  }
}
```

### AI 비서 추가 규칙 (01)
```
R01-01. 수확 시기·품질·가격 정확히 안내
R01-02. 체험 농장 프로그램 안내
R01-03. 직거래 배송 가능 지역·방법 안내
R01-04. 농약·인증 정보 정확히 안내 (소비자 신뢰)
```

---

## XI. 어업 (KSIC 03) ★★

### extra.public.biz (03)
```jsonc
{
  "public": {
    "biz": {
      "ksic_code":       "03",
      "ksic_name":       "어업",
      "fishery_type":    "해녀",
      "products": [
        {
          "id":    "fs001",
          "name":  "전복 (활)",
          "price": 40000,
          "unit":  "1kg",
          "season": "연중",
          "origin": "제주 한림 해역",
          "is_available": true
        }
      ],
      "live_seafood":    true,
      "experience":      false,
      "cooperative":     "한림수협"
    }
  }
}
```

---

## XII. 육상 운송업 (KSIC 49) ★★

> 렌터카·택시·버스·화물 포함

### extra.public.biz (49)
```jsonc
{
  "public": {
    "biz": {
      "ksic_code":       "49",
      "ksic_name":       "육상 운송업",
      "transport_type":  "렌터카",
      "vehicles": [
        {
          "id":       "v001",
          "name":     "아반떼 (경형)",
          "price":    50000,
          "unit":     "1일",
          "fuel":     "가솔린",
          "seats":    5,
          "is_available": true
        }
      ],
      "license_required":     true,
      "international_license": true,
      "min_age":              21,
      "insurance_included":   true,
      "pickup_locations":     ["제주공항", "한림읍사무소"]
    }
  }
}
```

---

## XIII. 부동산업 (KSIC 68) ★★

### extra.public.biz (68)
```jsonc
{
  "public": {
    "biz": {
      "ksic_code":       "68",
      "ksic_name":       "부동산업",
      "real_estate_type": "중개업",
      "specialties":     ["아파트", "상가", "농지"],
      "listings_count":  45,
      "service_area":    ["한림읍", "한경면", "애월읍"],
      "foreign_client":  true,
      "foreign_langs":   ["zh", "en", "ja"],
      "transaction_types": ["매매", "전세", "월세"]
    }
  }
}
```

### AI 비서 추가 규칙 (68)
```
R68-01. 부동산 가격 추세 예측·투자 조언 금지
R68-02. 매물 조건·위치 안내 가능
R68-03. 계약·등기 절차는 공인중개사 에스컬레이션
R68-04. 외국인 부동산 취득 제한 사항 안내 가능
         (단, 최종 판단은 전문가에게)
```

---

## XIV. 정보통신업 — 소프트웨어·IT (KSIC 62) ★★

### extra.public.biz (62)
```jsonc
{
  "public": {
    "biz": {
      "ksic_code":       "62",
      "ksic_name":       "컴퓨터 프로그래밍, 시스템 통합 및 관리업",
      "it_type":         "IT서비스",
      "services": [
        {
          "id":   "it001",
          "name": "홈페이지 제작",
          "price": 500000,
          "desc": "반응형 웹사이트, 1페이지 기준"
        }
      ],
      "remote_work":     true,
      "portfolio_url":   "",
      "tech_stack":      ["React", "Node.js", "Supabase"]
    }
  }
}
```

---

## XV. 예술·스포츠·여가 (KSIC 90~91) ★★

### extra.public.biz (90·91)
```jsonc
{
  "public": {
    "biz": {
      "ksic_code":       "91",
      "ksic_name":       "스포츠 및 오락관련 서비스업",
      "leisure_type":    "스쿠버 다이빙",
      "programs": [
        {
          "id":       "sp001",
          "name":     "체험 다이빙",
          "price":    80000,
          "duration": "3시간",
          "min_age":  10,
          "max_depth": "5m",
          "equipment_provided": true,
          "is_available": true
        }
      ],
      "certification_courses": true,
      "languages":      ["ko", "en", "zh", "ja"],
      "safety_cert":    "PADI 인증 강사",
      "insurance":      true
    }
  }
}
```

### AI 비서 추가 규칙 (90·91)
```
R91-01. 안전 규칙·필수 조건(나이·건강) 반드시 안내
R91-02. 날씨·해황 조건 변경 가능성 안내
R91-03. 예약 확정 → 결제 URL 안내
R91-04. 응급 상황 발생 시 즉시 119 안내
```

---

## XVI. 협회 및 단체 (KSIC 94) ★★

### extra.public.biz (94)
```jsonc
{
  "public": {
    "biz": {
      "ksic_code":       "94",
      "ksic_name":       "협회 및 단체",
      "org_type":        "상인회",
      "members_count":   48,
      "membership_open": true,
      "membership_fee":  120000,
      "membership_period": "연간",
      "activities": [
        "공동 마케팅",
        "지역 축제 참가",
        "GDC 결제 공동 도입"
      ],
      "public_events":   true
    }
  }
}
```

---

## XVII. 개인 서비스업 (KSIC 96) ★★

> 마사지·미용·세탁·사진 등

### extra.public.biz (96)
```jsonc
{
  "public": {
    "biz": {
      "ksic_code":       "96",
      "ksic_name":       "기타 개인 서비스업",
      "service_type":    "마사지",
      "services": [
        {
          "id":       "ps001",
          "name":     "타이 전통 마사지 (60분)",
          "price":    60000,
          "duration": 60,
          "therapist_lang": ["th", "ko", "en"],
          "is_available": true
        }
      ],
      "appointment_required": true,
      "gender_option": "여성 전용 가능",
      "cert": "타이 마사지 자격증"
    }
  }
}
```

---

## XVIII. 제조업 공통 템플릿 (KSIC 10~34) ★

> 25개 중분류 공통 적용. 고팡에서 직접 거래 대상은 식료품(10)·의약품(21)만 ★★

### extra.public.biz (10~34 공통)
```jsonc
{
  "public": {
    "biz": {
      "ksic_code":       "10",
      "ksic_name":       "식료품 제조업",
      "products": [
        {
          "id":    "mf001",
          "name":  "제주 된장",
          "price": 15000,
          "unit":  "500g",
          "cert":  "전통식품 인증",
          "shelf_life": "제조일로부터 12개월",
          "is_available": true
        }
      ],
      "b2b_available":   false,
      "b2c_available":   true,
      "factory_tour":    false,
      "origin":          "제주 한림읍"
    }
  }
}
```

---

## XIX. 건설업 (KSIC 41~42) ★

### extra.public.biz (41~42)
```jsonc
{
  "public": {
    "biz": {
      "ksic_code":       "42",
      "ksic_name":       "전문직별 공사업",
      "construction_type": "전기공사",
      "services": [
        {
          "id":   "cs001",
          "name": "전기 설비 점검",
          "price": 50000,
          "desc": "출장비 포함, 반경 10km"
        }
      ],
      "license":         "전기공사업 면허",
      "service_area":    ["한림읍", "한경면"],
      "emergency_call":  true
    }
  }
}
```

---

## XX. 운수·창고업 공통 (KSIC 50~52) ★★

### extra.public.biz (52)
```jsonc
{
  "public": {
    "biz": {
      "ksic_code":       "52",
      "ksic_name":       "창고 및 운송관련 서비스업",
      "logistics_type":  "택배",
      "services": [
        {
          "id":   "lg001",
          "name": "제주 → 육지 택배",
          "price": 4500,
          "desc": "1kg 기준, 2~3일 소요"
        }
      ],
      "same_day":        false,
      "cold_chain":      true,
      "tracking":        true
    }
  }
}
```

---

## XXI. 나머지 중분류 공통 최소 템플릿 (B·D·E·T·U)

> 고팡 직접 거래 빈도 낮음 — 최소한의 공통 구조만 정의

### extra.public.biz (공통 최소)
```jsonc
{
  "public": {
    "biz": {
      "ksic_code":       "XX",
      "ksic_name":       "분류명",
      "services": [
        {
          "id":   "s001",
          "name": "서비스명",
          "price": 0,
          "desc": "서비스 설명"
        }
      ],
      "contact_required": true,
      "custom_inquiry":   true
    }
  }
}
```

---

## 전체 KSIC 코드 → 고팡 entity_subtype 매핑표

| KSIC | 중분류명 | entity_subtype | 우선순위 | AI비서 |
|------|---------|----------------|----------|--------|
| 01 | 농업 | agri_farm | ★★ | ✅ |
| 02 | 임업 | forestry | ★ | — |
| 03 | 어업 | fishery | ★★ | ✅ |
| 05~08 | 광업 | mining | ★ | — |
| 10 | 식료품 제조 | food_mfg | ★★ | ✅ |
| 11 | 음료 제조 | beverage_mfg | ★ | — |
| 12~34 | 기타 제조업 | manufacturing | ★ | — |
| 35 | 전기·가스 | utility_energy | ★ | — |
| 36 | 수도업 | utility_water | ★ | — |
| 37~39 | 하수·폐기물·환경 | environment | ★ | — |
| 41~42 | 건설업 | construction | ★ | ✅(출장) |
| 45 | 자동차 판매 | auto_dealer | ★★ | ✅ |
| 46 | 도매·중개 | wholesale | ★ | — |
| 47 | 소매업 | retail | ★★★ | ✅ |
| 49 | 육상 운송 | transport_land | ★★ | ✅ |
| 50 | 수상 운송 | transport_sea | ★ | — |
| 51 | 항공 운송 | transport_air | ★ | — |
| 52 | 창고·운송서비스 | logistics | ★★ | ✅ |
| 55 | 숙박업 | accommodation | ★★★ | ✅ |
| 56 | 음식점·주점 | restaurant | ★★★ | ✅ |
| 58~60 | 출판·방송 | media | ★ | — |
| 61 | 통신업 | telecom | ★ | — |
| 62 | 소프트웨어·IT | it_service | ★★ | ✅ |
| 63 | 정보서비스 | info_service | ★★ | ✅ |
| 64 | 금융업 | finance_bank | ★★★ | ✅ |
| 65 | 보험·연금 | insurance | ★★ | ✅ |
| 66 | 금융서비스 | finance_service | ★★ | ✅ |
| 68 | 부동산업 | real_estate | ★★ | ✅ |
| 70 | 연구개발 | research | ★ | — |
| 71 | 전문서비스(법률·회계) | professional | ★★★ | ✅ |
| 72 | 건축·엔지니어링 | engineering | ★ | ✅ |
| 73 | 기타 전문·과학 | science_tech | ★ | — |
| 74 | 사업시설·조경 | facility_mgmt | ★ | — |
| 75 | 사업지원서비스 | biz_support | ★★ | ✅ |
| 76 | 임대업 | rental | ★★ | ✅ |
| 84 | 공공행정 | gov_admin | ★★★ | ✅ |
| 85 | 교육 서비스 | education | ★★★ | ✅ |
| 86 | 보건업 | healthcare | ★★★ | ✅ |
| 87 | 사회복지 | social_welfare | ★★★ | ✅ |
| 90 | 예술·여가 | arts_leisure | ★★ | ✅ |
| 91 | 스포츠·오락 | sports_recreation | ★★ | ✅ |
| 94 | 협회·단체 | association | ★★ | ✅ |
| 95 | 소비용품 수리 | repair | ★★ | ✅ |
| 96 | 개인서비스 | personal_service | ★★ | ✅ |
| 97~98 | 가구 내 고용·자가소비 | household | ★ | — |
| 99 | 국제기관 | international | ★ | — |

---

## AI 비서 System Prompt 조합 규칙

모든 업종의 AI 비서 프롬프트는 다음 순서로 조합됩니다.

```
최종 System Prompt =
  BasePrompt (Part 1 §1.7)
  + 업종별 추가 규칙 (Part 2 각 섹션)
  + 엔티티 정보 자동 주입 (런타임)

예시 — 금능반점(KSIC 56):
  [BasePrompt R01~R10]
  [R56-01~R56-05]
  [엔티티 정보: 이름, 주소, 영업시간, 메뉴 전체]
```

### 업종별 금지 행위 강도

| 업종 | 금지 강도 | 주요 금지 항목 |
|------|-----------|----------------|
| 보건업(86) | 최강 | 진단·처방·약 복용법 |
| 전문서비스(71) | 강 | 법률·세무 판단 |
| 금융(64) | 강 | 투자 조언 |
| 사회복지(87) | 중 | 의료적 판단 |
| 공공행정(84) | 중 | 행정 결정 |
| 음식점(56) | 일반 | 타 업체 비교 |
| 숙박(55) | 일반 | 예약 확정 |

---

## bulk_register.py 업종별 추가 CSV 컬럼

### 공통 추가 (모든 org/institution)
```
ksic_code, entity_subtype
```

### 음식점(56) 추가
```
cuisine_type, delivery, takeout, seating, halal, vegetarian, menu_json
```

### 숙박(55) 추가
```
accommodation_type, total_rooms, check_in, check_out, breakfast, pets
```

### 소매(47) 추가
```
retail_type, online_order, delivery, delivery_area_json
```

### 보건(86) 추가
```
facility_type, medical_dept_json, insurance_accepted, foreign_patient,
interpreter_langs, appointment_required
```

### 교육(85) 추가
```
education_type, target_age, languages, trial_class, online_available
```

### 공공행정(84) 추가
```
org_type, parent_org, jurisdiction, services_json,
emergency_contact, foreign_support
```

---

## 다음 단계 — Part 3 예정

```
Part 3 — 업종별 CSV 데이터 작성 (한림읍 28개 업체/기관)
Part 4 — bulk_register.py 업종별 extra JSONB 생성 로직 추가
Part 5 — 업종별 user_llm_keys system prompt SQL 생성
```

---

*GOPANG-PROFILE-DESIGN-PART2-v1.0 · 초안*  
*AI City Inc. · 2026-06-13*  
*한국표준산업분류 제11차 (KSIC 11차) 기준*
