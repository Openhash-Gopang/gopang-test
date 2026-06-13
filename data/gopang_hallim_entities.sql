-- 고팡 한림읍 28개 업체·기관 user_profiles INSERT
-- 생성일: 2026-06-13 | 기준: KSIC 제11차
-- 실행 위치: 테스트 전용 Supabase 프로젝트

BEGIN;

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  '31e82cad-76c3-5866-a039-f64ffeb2e694',
  'org',
  '금능반점',
  '@hallim_geumneung',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 한림리 123',
  33.3945,
  126.2389,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "org", "display_name": "금능반점", "description": "제주 한림 중화요리 전문점. 짜장면·짬뽕·탕수육", "tags": [], "entity_subtype": "restaurant"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1001", "phone_visible": true, "website": "", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "phone_verified"}, "digital": {"og_title": "금능반점", "og_description": "제주 한림 중화요리 전문점. 짜장면·짬뽕·탕수육", "featured": false}, "lifecycle": {"status": "active", "started_at": "2015-03-01", "status_message": ""}, "biz": {"cuisine_type": "중화요리", "menu": [{"id": "m001", "name": "짜장면", "price": 7000, "desc": "춘장 소스 중화 면", "allergens": ["대두", "밀"], "kcal": 650, "is_available": true}, {"id": "m002", "name": "짬뽕", "price": 8000, "desc": "매운 해물 국물 면", "allergens": ["갑각류", "밀"], "kcal": 720, "is_available": true}, {"id": "m003", "name": "탕수육", "price": 18000, "desc": "바삭 돼지고기·소스", "allergens": ["대두", "밀"], "kcal": 980, "is_available": true}, {"id": "m004", "name": "볶음밥", "price": 8000, "desc": "야채 볶음밥", "allergens": ["대두", "달걀"], "kcal": 700, "is_available": true}], "delivery": true, "delivery_fee": 3000, "takeout": true, "dine_in": true, "seating": 30, "halal": false, "vegetarian": false, "min_order": 7000, "kids_friendly": true}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 한림리 123"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 금능반점입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  '60012c7f-9a7c-50be-82c6-e9f6bca47912',
  'org',
  '갈매기 해산물',
  '@hallim_seagull',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 협재리 456',
  33.3921,
  126.2301,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "org", "display_name": "갈매기 해산물", "description": "협재 해변 앞 신선한 해산물 전문점", "tags": [], "entity_subtype": "restaurant"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1002", "phone_visible": true, "website": "", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "phone_verified"}, "digital": {"og_title": "갈매기 해산물", "og_description": "협재 해변 앞 신선한 해산물 전문점", "featured": false}, "lifecycle": {"status": "active", "started_at": "2018-05-01", "status_message": ""}, "biz": {"cuisine_type": "해산물", "menu": [{"id": "m001", "name": "전복죽", "price": 15000, "desc": "제주 전복 한 마리 포함", "allergens": ["갑각류"], "kcal": 420, "is_available": true}, {"id": "m002", "name": "해물뚝배기", "price": 12000, "desc": "각종 해물 된장찌개", "allergens": ["갑각류", "대두"], "kcal": 380, "is_available": true}, {"id": "m003", "name": "회 모듬", "price": 35000, "desc": "2인분 기준 당일 직접 조업", "allergens": ["생선"], "kcal": 350, "is_available": true}], "delivery": false, "takeout": true, "dine_in": true, "seating": 40, "halal": false, "vegetarian": false, "min_order": 12000}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 협재리 456"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 갈매기 해산물입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  '0e9efac9-4858-5533-b3e5-b4fcaf3a00ed',
  'org',
  '협재 카페',
  '@hyeopjae_cafe',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 협재리 789',
  33.3915,
  126.229,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "org", "display_name": "협재 카페", "description": "협재 해변 뷰 카페. 수제 디저트·제주 로컬 음료", "tags": [], "entity_subtype": "cafe"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1003", "phone_visible": true, "website": "", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "phone_verified"}, "digital": {"og_title": "협재 카페", "og_description": "협재 해변 뷰 카페. 수제 디저트·제주 로컬 음료", "featured": false}, "lifecycle": {"status": "active", "started_at": "2020-04-01", "status_message": ""}, "biz": {"cuisine_type": "카페", "menu": [{"id": "m001", "name": "아메리카노", "price": 5000, "desc": "제주 한라산 물 사용", "allergens": [], "kcal": 10, "is_available": true}, {"id": "m002", "name": "한라봉 에이드", "price": 7000, "desc": "제주 한라봉 생과일", "allergens": [], "kcal": 180, "is_available": true}, {"id": "m003", "name": "오메기떡 세트", "price": 9000, "desc": "제주 전통 오메기떡 3개", "allergens": ["밀", "대두"], "kcal": 320, "is_available": true}], "delivery": false, "takeout": true, "dine_in": true, "seating": 25, "halal": false, "vegetarian": true, "min_order": 5000}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 협재리 789"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 협재 카페입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  '497d04f7-81b0-55ef-8b3c-5fee90df1916',
  'org',
  '포홍 베트남 음식점',
  '@hallim_viet',
  'vi',
  true,
  '제주특별자치도 제주시 한림읍 한림리 321',
  33.395,
  126.24,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "org", "display_name": "포홍 베트남 음식점", "description": "정통 베트남 가정식. 쌀국수·분짜·반미", "tags": [], "entity_subtype": "restaurant"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1004", "phone_visible": true, "website": "", "languages_spoken": ["vi"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "phone_verified"}, "digital": {"og_title": "포홍 베트남 음식점", "og_description": "정통 베트남 가정식. 쌀국수·분짜·반미", "featured": false}, "lifecycle": {"status": "active", "started_at": "2021-08-01", "status_message": ""}, "biz": {"cuisine_type": "베트남 요리", "menu": [{"id": "m001", "name": "쌀국수 (소)", "price": 9000, "desc": "사골 육수 24시간 우린 포보", "allergens": ["밀", "대두"], "kcal": 480, "is_available": true}, {"id": "m002", "name": "분짜", "price": 11000, "desc": "숯불 돼지고기 분짜", "allergens": ["밀", "대두"], "kcal": 560, "is_available": true}, {"id": "m003", "name": "반미", "price": 7000, "desc": "바게트 베트남 샌드위치", "allergens": ["밀", "달걀"], "kcal": 420, "is_available": true}], "delivery": true, "delivery_fee": 3000, "takeout": true, "dine_in": true, "seating": 20, "halal": false, "vegetarian": false, "min_order": 9000}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 한림리 321"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 포홍 베트남 음식점입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  'f8e8172f-7452-540c-a01f-5d650a3d1651',
  'org',
  '이정호 민박',
  '@hallim_minjak',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 한림리 456',
  33.396,
  126.241,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "org", "display_name": "이정호 민박", "description": "한림읍 소재 가족 운영 민박. 주인 직접 제주 여행 안내", "tags": [], "entity_subtype": "accommodation"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1005", "phone_visible": true, "website": "", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "phone_verified"}, "digital": {"og_title": "이정호 민박", "og_description": "한림읍 소재 가족 운영 민박. 주인 직접 제주 여행 안내", "featured": false}, "lifecycle": {"status": "active", "started_at": "2010-06-01", "status_message": ""}, "biz": {"accommodation_type": "민박", "rooms": [{"id": "r001", "name": "온돌 방 (2인)", "price": 60000, "capacity": 2, "amenities": ["에어컨", "와이파이", "욕실"], "is_available": true}, {"id": "r002", "name": "패밀리 룸 (4인)", "price": 100000, "capacity": 4, "amenities": ["에어컨", "와이파이", "욕실", "주방"], "is_available": true}], "check_in": "15:00", "check_out": "11:00", "total_rooms": 4, "breakfast": false, "parking": true, "pets": false, "min_stay_nights": 1, "cancellation_policy": "체크인 2일 전 무료 취소"}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 한림리 456"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 이정호 민박입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  '87a3ca14-ce2c-5647-b1cb-046cebfc06ef',
  'org',
  '한림 바다 펜션',
  '@hallim_pension',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 협재리 111',
  33.391,
  126.228,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "org", "display_name": "한림 바다 펜션", "description": "협재 해수욕장 도보 2분. 오션뷰 펜션", "tags": [], "entity_subtype": "accommodation"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1006", "phone_visible": true, "website": "", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "phone_verified"}, "digital": {"og_title": "한림 바다 펜션", "og_description": "협재 해수욕장 도보 2분. 오션뷰 펜션", "featured": false}, "lifecycle": {"status": "active", "started_at": "2016-03-01", "status_message": ""}, "biz": {"accommodation_type": "펜션", "rooms": [{"id": "r001", "name": "오션뷰 스탠다드", "price": 120000, "capacity": 2, "amenities": ["에어컨", "와이파이", "욕실", "발코니"], "is_available": true}, {"id": "r002", "name": "오션뷰 패밀리", "price": 180000, "capacity": 4, "amenities": ["에어컨", "와이파이", "욕실", "주방", "바베큐"], "is_available": true}], "check_in": "16:00", "check_out": "11:00", "total_rooms": 8, "breakfast": false, "parking": true, "pets": true, "min_stay_nights": 1, "cancellation_policy": "체크인 3일 전 무료 취소"}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 협재리 111"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 한림 바다 펜션입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  'eb9c98d6-b64c-551b-a8f3-8e010a1c0200',
  'org',
  '한림 편의점',
  '@hallim_convenience',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 한림리 789',
  33.3948,
  126.2395,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "org", "display_name": "한림 편의점", "description": "24시간 운영 편의점. GDC 결제 가능", "tags": [], "entity_subtype": "retail"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1007", "phone_visible": true, "website": "", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "phone_verified"}, "digital": {"og_title": "한림 편의점", "og_description": "24시간 운영 편의점. GDC 결제 가능", "featured": false}, "lifecycle": {"status": "active", "started_at": "2019-01-01", "status_message": ""}, "biz": {"retail_type": "편의점", "online_order": false, "delivery": false, "pickup": true, "return_policy": "영수증 지참 당일 교환 가능"}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 한림리 789"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": false, "welcome_message": "안녕하세요, 한림 편의점입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  '8b9f1ada-56fa-5252-b67b-0d848cd3cdac',
  'org',
  '김복순 된장·젓갈',
  '@hallim_doejang',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 한림리 654',
  33.3955,
  126.242,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "org", "display_name": "김복순 된장·젓갈", "description": "3대째 전통 제주 된장·젓갈. 전국 배송 가능", "tags": [], "entity_subtype": "retail"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1008", "phone_visible": true, "website": "", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "phone_verified"}, "digital": {"og_title": "김복순 된장·젓갈", "og_description": "3대째 전통 제주 된장·젓갈. 전국 배송 가능", "featured": false}, "lifecycle": {"status": "active", "started_at": "1985-01-01", "status_message": ""}, "biz": {"retail_type": "전통식품", "products": [{"id": "p001", "name": "제주 된장 (500g)", "price": 15000, "unit": "병", "origin": "제주 한림읍", "cert": "전통식품 인증", "is_available": true}, {"id": "p002", "name": "멜젓 (500g)", "price": 12000, "unit": "병", "origin": "제주 앞바다", "cert": "", "is_available": true}, {"id": "p003", "name": "된장·젓갈 세트", "price": 45000, "unit": "선물세트", "origin": "제주", "cert": "전통식품 인증", "is_available": true}], "online_order": true, "delivery": true, "pickup": true, "delivery_area": ["전국"], "return_policy": "수령 후 3일 내 불량품만"}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 한림리 654"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 김복순 된장·젓갈입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  '42a0084f-a45b-57f6-9eac-41ab4fe1b9bd',
  'org',
  '백지영 농산물 직거래',
  '@hallim_directfarm',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 금악리 111',
  33.382,
  126.255,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "org", "display_name": "백지영 농산물 직거래", "description": "제주 농산물 농장 직거래. 한라봉·감귤·당근", "tags": [], "entity_subtype": "retail"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1009", "phone_visible": true, "website": "", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "phone_verified"}, "digital": {"og_title": "백지영 농산물 직거래", "og_description": "제주 농산물 농장 직거래. 한라봉·감귤·당근", "featured": false}, "lifecycle": {"status": "active", "started_at": "2017-11-01", "status_message": ""}, "biz": {"retail_type": "농산물 직거래", "products": [{"id": "p001", "name": "한라봉 (3kg)", "price": 25000, "unit": "박스", "season": "12월~2월", "cert": "GAP 인증", "is_available": false}, {"id": "p002", "name": "노지 감귤 (5kg)", "price": 20000, "unit": "박스", "season": "11월~1월", "cert": "GAP 인증", "is_available": true}, {"id": "p003", "name": "제주 당근 (3kg)", "price": 12000, "unit": "박스", "season": "11월~3월", "cert": "", "is_available": true}], "online_order": true, "delivery": true, "pickup": true, "delivery_area": ["전국"], "return_policy": "수령 24시간 내 불량품만"}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 금악리 111"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 백지영 농산물 직거래입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  '6c551e67-1ad8-5afb-a478-dbc3abb4a060',
  'org',
  '한정수 수산물',
  '@hallim_seafood',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 한림리 수협 앞',
  33.394,
  126.237,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "org", "display_name": "한정수 수산물", "description": "한림수협 인근 수산물 도매·소매. 당일 직접 조업", "tags": [], "entity_subtype": "retail"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1010", "phone_visible": true, "website": "", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "phone_verified"}, "digital": {"og_title": "한정수 수산물", "og_description": "한림수협 인근 수산물 도매·소매. 당일 직접 조업", "featured": false}, "lifecycle": {"status": "active", "started_at": "2005-08-01", "status_message": ""}, "biz": {"retail_type": "수산물", "products": [{"id": "p001", "name": "전복 (활, 1kg)", "price": 40000, "unit": "kg", "origin": "제주 한림 해역", "cert": "", "is_available": true}, {"id": "p002", "name": "옥돔 (냉장, 1마리)", "price": 35000, "unit": "마리", "origin": "제주 앞바다", "cert": "", "is_available": true}, {"id": "p003", "name": "갈치 (냉장, 1kg)", "price": 22000, "unit": "kg", "origin": "제주 앞바다", "cert": "", "is_available": true}], "online_order": true, "delivery": true, "pickup": true, "delivery_area": ["전국"], "return_policy": "당일 수령 불량품만"}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 한림리 수협 앞"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 한정수 수산물입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  '59f17032-c552-5882-a619-917df5dd9571',
  'org',
  '정우성 감귤 농장',
  '@hallim_geumneung_farm',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 금악리 234',
  33.38,
  126.258,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "org", "display_name": "정우성 감귤 농장", "description": "3대째 감귤 농장. 체험 농장 운영. GAP 인증", "tags": [], "entity_subtype": "agri_farm"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1011", "phone_visible": true, "website": "", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "phone_verified"}, "digital": {"og_title": "정우성 감귤 농장", "og_description": "3대째 감귤 농장. 체험 농장 운영. GAP 인증", "featured": false}, "lifecycle": {"status": "active", "started_at": "1975-01-01", "status_message": ""}, "biz": {"farm_type": "과수원", "products": [{"id": "ag001", "name": "노지 감귤 (5kg)", "price": 20000, "unit": "박스", "season": "11월~1월", "cert": "GAP 인증", "is_available": true}, {"id": "ag002", "name": "한라봉 (3kg)", "price": 28000, "unit": "박스", "season": "12월~2월", "cert": "GAP 인증", "is_available": false}], "direct_sale": true, "farm_experience": true, "experience_price": 10000, "organic": false, "gap_certified": true, "origin": "제주 한림읍 금악리"}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 금악리 234"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 정우성 감귤 농장입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  '0d83a354-bc70-5fea-acbe-f99c0b26254d',
  'org',
  '김태호 흑돼지 목장',
  '@hallim_blackpig',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 월림리 567',
  33.378,
  126.261,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "org", "display_name": "김태호 흑돼지 목장", "description": "제주 재래 흑돼지 목장. 방문 체험 가능", "tags": [], "entity_subtype": "agri_farm"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1012", "phone_visible": true, "website": "", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "phone_verified"}, "digital": {"og_title": "김태호 흑돼지 목장", "og_description": "제주 재래 흑돼지 목장. 방문 체험 가능", "featured": false}, "lifecycle": {"status": "active", "started_at": "2000-03-01", "status_message": ""}, "biz": {"farm_type": "축산", "products": [{"id": "ag001", "name": "흑돼지 삼겹살 (500g)", "price": 25000, "unit": "팩", "origin": "제주 한림읍", "cert": "제주 흑돼지 인증", "is_available": true}, {"id": "ag002", "name": "흑돼지 목살 (500g)", "price": 23000, "unit": "팩", "origin": "제주 한림읍", "cert": "제주 흑돼지 인증", "is_available": true}], "direct_sale": true, "farm_experience": true, "experience_price": 15000, "organic": false, "gap_certified": false, "origin": "제주 한림읍 월림리"}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 월림리 567"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 김태호 흑돼지 목장입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  'dbf8fd87-1ae2-5688-ae0a-8dbb2235ead4',
  'org',
  '한림 해녀 전복',
  '@hallim_haenyeo',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 수원리 해안',
  33.39,
  126.233,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "org", "display_name": "한림 해녀 전복", "description": "한림 해녀가 직접 잡은 전복·소라·해삼", "tags": [], "entity_subtype": "fishery"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1013", "phone_visible": true, "website": "", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "phone_verified"}, "digital": {"og_title": "한림 해녀 전복", "og_description": "한림 해녀가 직접 잡은 전복·소라·해삼", "featured": false}, "lifecycle": {"status": "active", "started_at": "1990-01-01", "status_message": ""}, "biz": {"fishery_type": "해녀", "products": [{"id": "fs001", "name": "전복 (활, 1kg)", "price": 42000, "unit": "kg", "season": "연중", "origin": "제주 한림 해역", "is_available": true}, {"id": "fs002", "name": "소라 (활, 1kg)", "price": 15000, "unit": "kg", "season": "5월~10월", "origin": "제주 한림 해역", "is_available": true}, {"id": "fs003", "name": "해삼 (냉장, 500g)", "price": 30000, "unit": "팩", "season": "겨울~봄", "origin": "제주 한림 해역", "is_available": false}], "live_seafood": true, "experience": false, "cooperative": "한림수협"}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 수원리 해안"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 한림 해녀 전복입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  'dc04c4e3-a8dd-5ba2-a139-2b8590687cfe',
  'institution',
  '한림병원',
  '@hallim_hospital',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 한림로 123',
  33.3965,
  126.245,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "institution", "display_name": "한림병원", "description": "한림읍 지역 거점 병원. 내과·외과·응급실 운영", "tags": [], "entity_subtype": "healthcare"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1014", "phone_visible": true, "website": "https://hallimhospital.co.kr", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "gov_verified"}, "digital": {"og_title": "한림병원", "og_description": "한림읍 지역 거점 병원. 내과·외과·응급실 운영", "featured": false}, "lifecycle": {"status": "active", "started_at": "1982-07-01", "status_message": ""}, "biz": {"facility_type": "병원", "medical_dept": ["내과", "외과", "정형외과", "응급의학과"], "services": [{"id": "s001", "name": "외래 진료", "price": 15000, "desc": "건강보험 본인부담금 기준", "requires_appointment": false}, {"id": "s002", "name": "응급실", "price": 0, "desc": "24시간 운영", "requires_appointment": false}, {"id": "s003", "name": "건강검진", "price": 80000, "desc": "기본 혈액검사 포함", "requires_appointment": true}], "insurance_accepted": true, "foreign_patient": true, "interpreter": ["en", "zh"], "emergency": true, "appointment_required": false}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 한림로 123"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 한림병원입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  '42e6b53b-2cb4-5d49-8b8d-9e3a8962dd88',
  'org',
  '한림약국',
  '@hallim_pharmacy',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 한림로 145',
  33.3963,
  126.2448,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "org", "display_name": "한림약국", "description": "한림병원 인근 약국. 처방전 조제 및 일반 의약품", "tags": [], "entity_subtype": "pharmacy"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1015", "phone_visible": true, "website": "", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "phone_verified"}, "digital": {"og_title": "한림약국", "og_description": "한림병원 인근 약국. 처방전 조제 및 일반 의약품", "featured": false}, "lifecycle": {"status": "active", "started_at": "1995-04-01", "status_message": ""}, "biz": {"facility_type": "약국", "medical_dept": ["약학"], "services": [{"id": "s001", "name": "처방전 조제", "price": 0, "desc": "처방전 지참 필수", "requires_appointment": false}, {"id": "s002", "name": "일반 의약품 판매", "price": 0, "desc": "소화제·감기약 등", "requires_appointment": false}], "insurance_accepted": true, "foreign_patient": true, "interpreter": [], "emergency": false, "appointment_required": false}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 한림로 145"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 한림약국입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  '4dafafb7-1649-59c8-9e6d-b380b8456e6c',
  'org',
  '최미경 한의원',
  '@hallim_hanjung',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 한림리 890',
  33.3942,
  126.2392,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "org", "display_name": "최미경 한의원", "description": "20년 경력 한방 의원. 침·뜸·한약 처방", "tags": [], "entity_subtype": "korean_medicine"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1016", "phone_visible": true, "website": "", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "phone_verified"}, "digital": {"og_title": "최미경 한의원", "og_description": "20년 경력 한방 의원. 침·뜸·한약 처방", "featured": false}, "lifecycle": {"status": "active", "started_at": "2004-09-01", "status_message": ""}, "biz": {"facility_type": "한의원", "medical_dept": ["한방내과", "침구과", "한방재활의학과"], "services": [{"id": "s001", "name": "초진 상담", "price": 20000, "desc": "기본 진찰 및 처방", "requires_appointment": true}, {"id": "s002", "name": "침 치료", "price": 15000, "desc": "1회 기준 건강보험 적용", "requires_appointment": false}], "insurance_accepted": true, "foreign_patient": true, "interpreter": ["zh"], "emergency": false, "appointment_required": true}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 한림리 890"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 최미경 한의원입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  'dba7a92b-fbd6-535f-83cf-45e13c54e5d8',
  'org',
  '문성준 치과',
  '@hallim_dental',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 한림리 901',
  33.3944,
  126.2396,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "org", "display_name": "문성준 치과", "description": "한림 치과. 임플란트·교정·일반 치료", "tags": [], "entity_subtype": "dental"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1017", "phone_visible": true, "website": "", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "phone_verified"}, "digital": {"og_title": "문성준 치과", "og_description": "한림 치과. 임플란트·교정·일반 치료", "featured": false}, "lifecycle": {"status": "active", "started_at": "2010-02-01", "status_message": ""}, "biz": {"facility_type": "치과의원", "medical_dept": ["보존과", "보철과", "교정과"], "services": [{"id": "s001", "name": "스케일링", "price": 15000, "desc": "연 1회 건강보험 적용", "requires_appointment": true}, {"id": "s002", "name": "충치 치료", "price": 30000, "desc": "보험 적용 기준", "requires_appointment": true}, {"id": "s003", "name": "임플란트 상담", "price": 0, "desc": "비용 별도 상담", "requires_appointment": true}], "insurance_accepted": true, "foreign_patient": true, "interpreter": [], "emergency": false, "appointment_required": true}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 한림리 901"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 문성준 치과입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  '41ef3b6c-e7fb-59fd-b999-6237ccf79209',
  'institution',
  '한림읍 보건소',
  '@hallim_health',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 한림로 200',
  33.397,
  126.246,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "institution", "display_name": "한림읍 보건소", "description": "한림읍 공공 보건 서비스. 예방접종·건강검진·방문 간호", "tags": [], "entity_subtype": "public_health"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1018", "phone_visible": true, "website": "https://www.jeju.go.kr/hallim", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "gov_verified"}, "digital": {"og_title": "한림읍 보건소", "og_description": "한림읍 공공 보건 서비스. 예방접종·건강검진·방문 간호", "featured": false}, "lifecycle": {"status": "active", "started_at": "1980-01-01", "status_message": ""}, "biz": {"facility_type": "보건소", "medical_dept": ["예방의학", "방문간호", "금연클리닉"], "services": [{"id": "s001", "name": "예방접종", "price": 0, "desc": "무료 (대상자 확인 필요)", "requires_appointment": false}, {"id": "s002", "name": "국가 건강검진", "price": 0, "desc": "대상자 무료", "requires_appointment": true}, {"id": "s003", "name": "방문 간호", "price": 0, "desc": "65세 이상 노인 대상 무료", "requires_appointment": false}], "insurance_accepted": true, "foreign_patient": true, "interpreter": ["en", "zh"], "emergency": false, "appointment_required": false}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 한림로 200"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 한림읍 보건소입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  'a884a8b9-5b08-56e5-8e0c-2d97a626c96a',
  'institution',
  '한림초등학교',
  '@hallim_school',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 한림로 300',
  33.3975,
  126.247,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "institution", "display_name": "한림초등학교", "description": "1945년 설립 한림읍 공립 초등학교. 전교생 320명", "tags": [], "entity_subtype": "elementary_school"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1019", "phone_visible": true, "website": "https://hallim-e.jje.go.kr", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "gov_verified"}, "digital": {"og_title": "한림초등학교", "og_description": "1945년 설립 한림읍 공립 초등학교. 전교생 320명", "featured": false}, "lifecycle": {"status": "active", "started_at": "1945-09-01", "status_message": ""}, "biz": {"education_type": "초등학교", "programs": [{"id": "c001", "name": "방과후 영어", "price": 50000, "duration": "월 20회", "capacity": 15, "age_range": "초등 1~6학년", "is_available": true}, {"id": "c002", "name": "방과후 코딩", "price": 50000, "duration": "월 8회", "capacity": 12, "age_range": "초등 3~6학년", "is_available": true}], "target_age": ["초등학생"], "languages": ["ko"], "trial_class": false, "online_available": false}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 한림로 300"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 한림초등학교입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  '8be25968-136e-5b40-be4a-b03a32489a17',
  'org',
  '박선미 도예 공방',
  '@hallim_doye',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 한림리 222',
  33.3958,
  126.2415,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "org", "display_name": "박선미 도예 공방", "description": "제주 전통 도예 체험 공방. 성인·가족 원데이 클래스", "tags": [], "entity_subtype": "art_studio"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1020", "phone_visible": true, "website": "", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "phone_verified"}, "digital": {"og_title": "박선미 도예 공방", "og_description": "제주 전통 도예 체험 공방. 성인·가족 원데이 클래스", "featured": false}, "lifecycle": {"status": "active", "started_at": "2012-05-01", "status_message": ""}, "biz": {"education_type": "공방·문화센터", "programs": [{"id": "c001", "name": "도예 체험 (원데이)", "price": 35000, "duration": "2시간", "capacity": 8, "age_range": "성인·가족", "is_available": true}, {"id": "c002", "name": "도예 정기반 (월)", "price": 120000, "duration": "월 8회", "capacity": 6, "age_range": "성인", "is_available": true}], "target_age": ["성인", "가족"], "languages": ["ko", "en", "zh"], "trial_class": true, "trial_price": 35000, "online_available": false}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 한림리 222"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 박선미 도예 공방입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  '57aae2f2-8eaa-5358-882b-8842f3dc6e3f',
  'org',
  '글로벌 영어 학원',
  '@hallim_english',
  'en',
  true,
  '제주특별자치도 제주시 한림읍 한림리 333',
  33.3953,
  126.2405,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "org", "display_name": "글로벌 영어 학원", "description": "원어민 강사 영어 회화·비즈니스 영어. 외국인 한국어 강의", "tags": [], "entity_subtype": "language_school"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1021", "phone_visible": true, "website": "", "languages_spoken": ["en"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "phone_verified"}, "digital": {"og_title": "글로벌 영어 학원", "og_description": "원어민 강사 영어 회화·비즈니스 영어. 외국인 한국어 강의", "featured": false}, "lifecycle": {"status": "active", "started_at": "2018-03-01", "status_message": ""}, "biz": {"education_type": "어학원", "programs": [{"id": "c001", "name": "영어 회화 (성인)", "price": 150000, "duration": "월 12회", "capacity": 8, "age_range": "성인", "is_available": true}, {"id": "c002", "name": "한국어 (외국인)", "price": 150000, "duration": "월 12회", "capacity": 6, "age_range": "성인", "is_available": true}], "target_age": ["성인", "청소년"], "languages": ["en", "ko"], "trial_class": true, "trial_price": 0, "online_available": true}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 한림리 333"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 글로벌 영어 학원입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  'a1ff9193-fd60-5905-93d9-08da9166ecd2',
  'institution',
  '제주시청 민원실',
  '@hallim_cityhall',
  'ko',
  true,
  '제주특별자치도 제주시 문연로 6',
  33.4996,
  126.5312,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "institution", "display_name": "제주시청 민원실", "description": "제주시청 민원실. 각종 증명서 발급·민원 처리", "tags": [], "entity_subtype": "gov_admin"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-728-2000", "phone_visible": true, "website": "https://www.jeju.go.kr", "languages_spoken": ["ko"]}, "location": {"region": "제주시", "address_short": "제주시", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "gov_verified"}, "digital": {"og_title": "제주시청 민원실", "og_description": "제주시청 민원실. 각종 증명서 발급·민원 처리", "featured": false}, "lifecycle": {"status": "active", "started_at": "1955-01-01", "status_message": ""}, "biz": {"org_type": "시청 민원실", "parent_org": "제주특별자치도 제주시", "jurisdiction": "제주시 전체", "services": [{"id": "sv001", "name": "주민등록 등·초본 발급", "desc": "본인 신분증, 수수료 400원", "online": true, "online_url": "https://www.gov.kr"}, {"id": "sv002", "name": "인감증명서 발급", "desc": "본인 신분증·인감도장 지참", "online": true, "online_url": "https://www.gov.kr"}, {"id": "sv003", "name": "건축 인허가 민원", "desc": "담당 부서 연결 필요", "online": false, "phone": "064-728-2345"}], "emergency_contact": "064-728-2000", "after_hours": "당직실 064-728-2001", "foreign_support": true, "foreign_langs": ["en", "zh", "ja"]}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 문연로 6"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 제주시청 민원실입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  'dac83401-c173-53e8-b6ee-4d0f0e5f17f7',
  'institution',
  '한림읍사무소',
  '@hallim_office',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 한림로 400',
  33.398,
  126.248,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "institution", "display_name": "한림읍사무소", "description": "한림읍 주민 행정 서비스. 민원·복지·상하수도", "tags": [], "entity_subtype": "gov_admin"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-728-2661", "phone_visible": true, "website": "https://www.jeju.go.kr/hallim", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "gov_verified"}, "digital": {"og_title": "한림읍사무소", "og_description": "한림읍 주민 행정 서비스. 민원·복지·상하수도", "featured": false}, "lifecycle": {"status": "active", "started_at": "1955-01-01", "status_message": ""}, "biz": {"org_type": "읍사무소", "parent_org": "제주특별자치도 제주시", "jurisdiction": "한림읍 전체", "services": [{"id": "sv001", "name": "주민등록 신고", "desc": "신분증 지참", "online": true, "online_url": "https://www.gov.kr"}, {"id": "sv002", "name": "상하수도 민원", "desc": "누수 신고·개폐전 신청", "online": false, "phone": "064-728-2661"}, {"id": "sv003", "name": "복지 급여 신청", "desc": "기초생활수급·긴급복지", "online": false, "phone": "064-728-2663"}], "emergency_contact": "064-728-2661", "after_hours": "제주시청 당직 064-728-2001", "foreign_support": true, "foreign_langs": ["en", "zh"]}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 한림로 400"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 한림읍사무소입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  '8745e2c9-7d62-55fa-8842-d97700559b75',
  'institution',
  '한림 119 안전센터',
  '@hallim_119',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 한림로 500',
  33.3985,
  126.249,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "institution", "display_name": "한림 119 안전센터", "description": "한림읍 소방·구조·구급 서비스. 긴급 시 119", "tags": [], "entity_subtype": "fire_station"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "119", "phone_visible": true, "website": "https://fire.jeju.go.kr", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "gov_verified"}, "digital": {"og_title": "한림 119 안전센터", "og_description": "한림읍 소방·구조·구급 서비스. 긴급 시 119", "featured": false}, "lifecycle": {"status": "active", "started_at": "1990-01-01", "status_message": ""}, "biz": {"org_type": "119 안전센터", "parent_org": "제주소방서", "jurisdiction": "한림읍·한경면·애월읍 일부", "services": [{"id": "sv001", "name": "화재 신고·진압", "desc": "긴급 시 119 즉시 신고", "online": false, "phone": "119"}, {"id": "sv002", "name": "구조", "desc": "교통사고·추락·수난 구조", "online": false, "phone": "119"}, {"id": "sv003", "name": "구급 (응급의료)", "desc": "24시간 구급대 운영", "online": false, "phone": "119"}], "emergency_contact": "119", "after_hours": "119 (24시간)", "foreign_support": true, "foreign_langs": ["en", "zh", "ja"]}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 한림로 500"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 한림 119 안전센터입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  '54069c44-79cc-5155-be44-bd840e14bb80',
  'institution',
  '한림읍 복지관',
  '@hallim_welfare',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 한림로 600',
  33.399,
  126.25,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "institution", "display_name": "한림읍 복지관", "description": "한림읍 사회복지관. 노인·장애인·취약계층 서비스", "tags": [], "entity_subtype": "social_welfare"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1025", "phone_visible": true, "website": "", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "gov_verified"}, "digital": {"og_title": "한림읍 복지관", "og_description": "한림읍 사회복지관. 노인·장애인·취약계층 서비스", "featured": false}, "lifecycle": {"status": "active", "started_at": "2000-03-01", "status_message": ""}, "biz": {"welfare_type": "종합사회복지관", "target_group": ["노인", "장애인", "저소득층"], "services": [{"id": "w001", "name": "노인 주간보호", "desc": "만 65세 이상, 장기요양등급 보유자", "fee_type": "장기요양보험 적용"}, {"id": "w002", "name": "장애인 활동지원", "desc": "활동보조인 연계", "fee_type": "장애인 활동지원 급여"}, {"id": "w003", "name": "푸드뱅크", "desc": "취약계층 식품 지원", "fee_type": "무료"}], "capacity": 50, "waiting_list": true, "gov_certified": true, "cert_number": "제주-복지-2000-001"}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 한림로 600"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 한림읍 복지관입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  '9b6f5310-d4f8-55b9-8f2d-94fc2b360846',
  'org',
  '임서연 법률 사무소',
  '@hallim_lawoffice',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 한림로 700',
  33.3962,
  126.244,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "org", "display_name": "임서연 법률 사무소", "description": "한림읍 법률 사무소. 부동산·계약·가족법 전문", "tags": [], "entity_subtype": "law_firm"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1026", "phone_visible": true, "website": "", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "phone_verified"}, "digital": {"og_title": "임서연 법률 사무소", "og_description": "한림읍 법률 사무소. 부동산·계약·가족법 전문", "featured": false}, "lifecycle": {"status": "active", "started_at": "2016-01-01", "status_message": ""}, "biz": {"service_type": "법률서비스", "specialties": ["부동산", "계약법", "가족법", "외국인 법률"], "services": [{"id": "l001", "name": "법률 상담 (30분)", "price": 50000, "desc": "초기 상담"}, {"id": "l002", "name": "계약서 검토", "price": 150000, "desc": "표준 계약서 기준"}], "languages": ["ko", "zh", "en"], "bar_certified": true, "consultation_method": ["대면", "전화", "화상"], "appointment_required": true}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 한림로 700"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 임서연 법률 사무소입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  '60530326-de24-5342-90e8-5cab433711b7',
  'org',
  '신재혁 다이빙 센터',
  '@hallim_diving',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 협재리 해변 앞',
  33.3912,
  126.2285,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "org", "display_name": "신재혁 다이빙 센터", "description": "협재 해변 스쿠버 다이빙. PADI 공인 강사 2명", "tags": [], "entity_subtype": "sports_recreation"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1027", "phone_visible": true, "website": "", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "phone_verified"}, "digital": {"og_title": "신재혁 다이빙 센터", "og_description": "협재 해변 스쿠버 다이빙. PADI 공인 강사 2명", "featured": false}, "lifecycle": {"status": "active", "started_at": "2015-06-01", "status_message": ""}, "biz": {"leisure_type": "스쿠버 다이빙", "programs": [{"id": "sp001", "name": "체험 다이빙", "price": 80000, "duration": "3시간", "min_age": 10, "max_depth": "5m", "equipment_provided": true, "is_available": true}, {"id": "sp002", "name": "PADI OW 자격증", "price": 350000, "duration": "3일", "min_age": 15, "max_depth": "18m", "equipment_provided": true, "is_available": true}], "certification_courses": true, "languages": ["ko", "en", "zh", "ja"], "safety_cert": "PADI 인증 강사", "insurance": true}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 협재리 해변 앞"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 신재혁 다이빙 센터입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

INSERT INTO user_profiles (
  guid, entity_type, name, handle, native_lang, is_public,
  address, lat, lng, extra, created_at, updated_at
) VALUES (
  'ba5bae4b-3b92-5257-a938-30af16e98ae6',
  'org',
  '한림 렌터카',
  '@hallim_rentcar',
  'ko',
  true,
  '제주특별자치도 제주시 한림읍 한림로 800',
  33.3966,
  126.2455,
  '{"public": {"identity": {"_schema_version": "2.0", "_entity_type": "org", "display_name": "한림 렌터카", "description": "한림읍 렌터카. 제주공항·숙소 픽업 가능", "tags": [], "entity_subtype": "transport_land"}, "activity": {"timezone": "Asia/Seoul", "hours": [{"day": "mon", "open": "09:00", "close": "18:00"}, {"day": "tue", "open": "09:00", "close": "18:00"}, {"day": "wed", "open": "09:00", "close": "18:00"}, {"day": "thu", "open": "09:00", "close": "18:00"}, {"day": "fri", "open": "09:00", "close": "18:00"}, {"day": "sat", "open": null, "close": null}, {"day": "sun", "open": null, "close": null}], "holidays": [], "is_open_now": true}, "contact": {"phone_display": "064-796-1028", "phone_visible": true, "website": "", "languages_spoken": ["ko"]}, "location": {"region": "한림읍", "address_short": "한림읍", "parking": false, "wheelchair": false}, "finance": {"gdc_accepted": true, "currencies": ["GDC"], "fee_rate": 3.0}, "reputation": {"overall_rating": 0, "review_count": 0, "trust_badge": "phone_verified"}, "digital": {"og_title": "한림 렌터카", "og_description": "한림읍 렌터카. 제주공항·숙소 픽업 가능", "featured": false}, "lifecycle": {"status": "active", "started_at": "2013-04-01", "status_message": ""}, "biz": {"transport_type": "렌터카", "vehicles": [{"id": "v001", "name": "경차 (모닝)", "price": 45000, "unit": "1일", "fuel": "가솔린", "seats": 4, "is_available": true}, {"id": "v002", "name": "준중형 (아반떼)", "price": 60000, "unit": "1일", "fuel": "가솔린", "seats": 5, "is_available": true}, {"id": "v003", "name": "SUV (투싼)", "price": 80000, "unit": "1일", "fuel": "가솔린", "seats": 5, "is_available": true}, {"id": "v004", "name": "전기차 (아이오닉6)", "price": 75000, "unit": "1일", "fuel": "전기", "seats": 5, "is_available": true}], "license_required": true, "international_license": true, "min_age": 21, "insurance_included": true, "pickup_locations": ["제주공항", "한림읍사무소", "협재해수욕장"]}}, "semi": {"location": {"address_full": "제주특별자치도 제주시 한림읍 한림로 800"}}, "private": {"finance": {"fs": {"bs-cash": 0, "pl-purchase": 0, "pl-revenue": 0}}, "preference": {"ai": {"ai_active": true, "welcome_message": "안녕하세요, 한림 렌터카입니다. 무엇을 도와드릴까요?", "off_hours_message": "현재 운영 시간이 아닙니다.", "escalate_to": null, "escalate_delay_s": 30}}}}'::jsonb,
  now(), now()
) ON CONFLICT (guid) DO UPDATE SET
  name         = EXCLUDED.name,
  address      = EXCLUDED.address,
  lat          = EXCLUDED.lat,
  lng          = EXCLUDED.lng,
  extra        = EXCLUDED.extra,
  updated_at   = now();

-- GDC 초기 잔액 — 테스트용 각 엔티티 ₮1,000,000 지급
INSERT INTO fs_ledger (guid, direction, amount, fs_account, source, memo, tx_at)
SELECT guid, 'credit', 1000000, 'bs-cash', 'manual', '테스트용 초기 GDC 잔액 지급', now()
FROM user_profiles
WHERE guid IN (
  '31e82cad-76c3-5866-a039-f64ffeb2e694',
  '60012c7f-9a7c-50be-82c6-e9f6bca47912',
  '0e9efac9-4858-5533-b3e5-b4fcaf3a00ed',
  '497d04f7-81b0-55ef-8b3c-5fee90df1916',
  'f8e8172f-7452-540c-a01f-5d650a3d1651',
  '87a3ca14-ce2c-5647-b1cb-046cebfc06ef',
  'eb9c98d6-b64c-551b-a8f3-8e010a1c0200',
  '8b9f1ada-56fa-5252-b67b-0d848cd3cdac',
  '42a0084f-a45b-57f6-9eac-41ab4fe1b9bd',
  '6c551e67-1ad8-5afb-a478-dbc3abb4a060',
  '59f17032-c552-5882-a619-917df5dd9571',
  '0d83a354-bc70-5fea-acbe-f99c0b26254d',
  'dbf8fd87-1ae2-5688-ae0a-8dbb2235ead4',
  'dc04c4e3-a8dd-5ba2-a139-2b8590687cfe',
  '42e6b53b-2cb4-5d49-8b8d-9e3a8962dd88',
  '4dafafb7-1649-59c8-9e6d-b380b8456e6c',
  'dba7a92b-fbd6-535f-83cf-45e13c54e5d8',
  '41ef3b6c-e7fb-59fd-b999-6237ccf79209',
  'a884a8b9-5b08-56e5-8e0c-2d97a626c96a',
  '8be25968-136e-5b40-be4a-b03a32489a17',
  '57aae2f2-8eaa-5358-882b-8842f3dc6e3f',
  'a1ff9193-fd60-5905-93d9-08da9166ecd2',
  'dac83401-c173-53e8-b6ee-4d0f0e5f17f7',
  '8745e2c9-7d62-55fa-8842-d97700559b75',
  '54069c44-79cc-5155-be44-bd840e14bb80',
  '9b6f5310-d4f8-55b9-8f2d-94fc2b360846',
  '60530326-de24-5342-90e8-5cab433711b7',
  'ba5bae4b-3b92-5257-a938-30af16e98ae6'
);

-- extra.fs 초기화
UPDATE user_profiles
SET extra = jsonb_set(
  extra, '{private,finance,fs}',
  '{"bs-cash":1000000,"pl-purchase":0,"pl-revenue":0}'::jsonb)
WHERE guid IN (
  '31e82cad-76c3-5866-a039-f64ffeb2e694',
  '60012c7f-9a7c-50be-82c6-e9f6bca47912',
  '0e9efac9-4858-5533-b3e5-b4fcaf3a00ed',
  '497d04f7-81b0-55ef-8b3c-5fee90df1916',
  'f8e8172f-7452-540c-a01f-5d650a3d1651',
  '87a3ca14-ce2c-5647-b1cb-046cebfc06ef',
  'eb9c98d6-b64c-551b-a8f3-8e010a1c0200',
  '8b9f1ada-56fa-5252-b67b-0d848cd3cdac',
  '42a0084f-a45b-57f6-9eac-41ab4fe1b9bd',
  '6c551e67-1ad8-5afb-a478-dbc3abb4a060',
  '59f17032-c552-5882-a619-917df5dd9571',
  '0d83a354-bc70-5fea-acbe-f99c0b26254d',
  'dbf8fd87-1ae2-5688-ae0a-8dbb2235ead4',
  'dc04c4e3-a8dd-5ba2-a139-2b8590687cfe',
  '42e6b53b-2cb4-5d49-8b8d-9e3a8962dd88',
  '4dafafb7-1649-59c8-9e6d-b380b8456e6c',
  'dba7a92b-fbd6-535f-83cf-45e13c54e5d8',
  '41ef3b6c-e7fb-59fd-b999-6237ccf79209',
  'a884a8b9-5b08-56e5-8e0c-2d97a626c96a',
  '8be25968-136e-5b40-be4a-b03a32489a17',
  '57aae2f2-8eaa-5358-882b-8842f3dc6e3f',
  'a1ff9193-fd60-5905-93d9-08da9166ecd2',
  'dac83401-c173-53e8-b6ee-4d0f0e5f17f7',
  '8745e2c9-7d62-55fa-8842-d97700559b75',
  '54069c44-79cc-5155-be44-bd840e14bb80',
  '9b6f5310-d4f8-55b9-8f2d-94fc2b360846',
  '60530326-de24-5342-90e8-5cab433711b7',
  'ba5bae4b-3b92-5257-a938-30af16e98ae6'
);

COMMIT;

-- 검증 쿼리
SELECT entity_type, COUNT(*) FROM user_profiles
WHERE guid IN (
  '31e82cad-76c3-5866-a039-f64ffeb2e694',
  '60012c7f-9a7c-50be-82c6-e9f6bca47912',
  '0e9efac9-4858-5533-b3e5-b4fcaf3a00ed',
  '497d04f7-81b0-55ef-8b3c-5fee90df1916',
  'f8e8172f-7452-540c-a01f-5d650a3d1651',
  '87a3ca14-ce2c-5647-b1cb-046cebfc06ef',
  'eb9c98d6-b64c-551b-a8f3-8e010a1c0200',
  '8b9f1ada-56fa-5252-b67b-0d848cd3cdac',
  '42a0084f-a45b-57f6-9eac-41ab4fe1b9bd',
  '6c551e67-1ad8-5afb-a478-dbc3abb4a060',
  '59f17032-c552-5882-a619-917df5dd9571',
  '0d83a354-bc70-5fea-acbe-f99c0b26254d',
  'dbf8fd87-1ae2-5688-ae0a-8dbb2235ead4',
  'dc04c4e3-a8dd-5ba2-a139-2b8590687cfe',
  '42e6b53b-2cb4-5d49-8b8d-9e3a8962dd88',
  '4dafafb7-1649-59c8-9e6d-b380b8456e6c',
  'dba7a92b-fbd6-535f-83cf-45e13c54e5d8',
  '41ef3b6c-e7fb-59fd-b999-6237ccf79209',
  'a884a8b9-5b08-56e5-8e0c-2d97a626c96a',
  '8be25968-136e-5b40-be4a-b03a32489a17',
  '57aae2f2-8eaa-5358-882b-8842f3dc6e3f',
  'a1ff9193-fd60-5905-93d9-08da9166ecd2',
  'dac83401-c173-53e8-b6ee-4d0f0e5f17f7',
  '8745e2c9-7d62-55fa-8842-d97700559b75',
  '54069c44-79cc-5155-be44-bd840e14bb80',
  '9b6f5310-d4f8-55b9-8f2d-94fc2b360846',
  '60530326-de24-5342-90e8-5cab433711b7',
  'ba5bae4b-3b92-5257-a938-30af16e98ae6'
) GROUP BY entity_type;
-- 기대값: org=21, institution=7