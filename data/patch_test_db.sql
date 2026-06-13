-- gopang-test Supabase 패치
-- 기존 user_profiles에 누락된 컬럼 추가
-- 실행 전 확인: SELECT column_name FROM information_schema.columns WHERE table_name='user_profiles';

BEGIN;

-- 1. user_profiles 누락 컬럼 추가
ALTER TABLE user_profiles
  ADD COLUMN IF NOT EXISTS native_lang      TEXT DEFAULT 'ko',
  ADD COLUMN IF NOT EXISTS is_public        BOOLEAN DEFAULT true,
  ADD COLUMN IF NOT EXISTS handle           TEXT,
  ADD COLUMN IF NOT EXISTS lat              FLOAT,
  ADD COLUMN IF NOT EXISTS lng              FLOAT,
  ADD COLUMN IF NOT EXISTS geo_updated_at   TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS extra            JSONB DEFAULT '{}'::jsonb;

-- 2. handle UNIQUE 제약 (없으면 추가)
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'user_profiles_handle_key'
  ) THEN
    ALTER TABLE user_profiles ADD CONSTRAINT user_profiles_handle_key UNIQUE (handle);
  END IF;
END $$;

-- 3. entity_type 허용값 확인 (individual → consumer 매핑)
-- 기존 스키마: 'individual' | 'org' | 'institution'
-- 신규 스키마: 'consumer' | 'org' | 'institution'
-- → 기존 CHECK 제약이 있으면 DROP 후 재생성
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname LIKE 'user_profiles_entity_type%'
  ) THEN
    ALTER TABLE user_profiles DROP CONSTRAINT IF EXISTS user_profiles_entity_type_check;
  END IF;
END $$;

ALTER TABLE user_profiles
  ADD CONSTRAINT user_profiles_entity_type_check
  CHECK (entity_type IN ('consumer','individual','org','institution'));

-- 4. 인덱스 추가
CREATE INDEX IF NOT EXISTS idx_up_handle   ON user_profiles(handle);
CREATE INDEX IF NOT EXISTS idx_up_lang     ON user_profiles(native_lang);
CREATE INDEX IF NOT EXISTS idx_up_location ON user_profiles(lat, lng)
  WHERE lat IS NOT NULL AND lng IS NOT NULL;

COMMIT;

-- 검증: 컬럼 목록 확인
SELECT column_name, data_type, column_default
FROM information_schema.columns
WHERE table_name = 'user_profiles'
ORDER BY ordinal_position;
