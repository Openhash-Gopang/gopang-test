-- gopang-test Supabase 패치 v3
-- 실제 DB entity_type 값: business(1), individual(3), platform(1), person(17), org(38)
-- 신규 추가: consumer, institution

BEGIN;

-- 1. 누락 컬럼 추가
ALTER TABLE user_profiles
  ADD COLUMN IF NOT EXISTS native_lang      TEXT DEFAULT 'ko',
  ADD COLUMN IF NOT EXISTS is_public        BOOLEAN DEFAULT true,
  ADD COLUMN IF NOT EXISTS handle           TEXT,
  ADD COLUMN IF NOT EXISTS lat              FLOAT,
  ADD COLUMN IF NOT EXISTS lng              FLOAT,
  ADD COLUMN IF NOT EXISTS geo_updated_at   TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS extra            JSONB DEFAULT '{}'::jsonb;

-- 2. 기존 CHECK 제약 제거
ALTER TABLE user_profiles
  DROP CONSTRAINT IF EXISTS user_profiles_entity_type_check;

-- 3. 실제 존재하는 값 + 신규 값 모두 허용
ALTER TABLE user_profiles
  ADD CONSTRAINT user_profiles_entity_type_check
  CHECK (entity_type IN (
    'person', 'individual', 'consumer',   -- 개인 계열
    'org', 'business',                    -- 사업자 계열
    'institution',                        -- 기관
    'platform'                            -- 플랫폼 내부
  ));

-- 4. handle UNIQUE 제약
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'user_profiles_handle_key'
      AND conrelid = 'user_profiles'::regclass
  ) THEN
    ALTER TABLE user_profiles
      ADD CONSTRAINT user_profiles_handle_key UNIQUE (handle);
  END IF;
END $$;

-- 5. 인덱스
CREATE INDEX IF NOT EXISTS idx_up_handle
  ON user_profiles(handle) WHERE handle IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_up_native_lang
  ON user_profiles(native_lang);
CREATE INDEX IF NOT EXISTS idx_up_location
  ON user_profiles(lat, lng)
  WHERE lat IS NOT NULL AND lng IS NOT NULL;

COMMIT;

-- 검증
SELECT entity_type, COUNT(*) FROM user_profiles GROUP BY entity_type ORDER BY entity_type;
