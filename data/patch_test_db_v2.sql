-- gopang-test Supabase 패치 v2
-- 오류 원인: entity_type CHECK 제약 교체 시 기존 'individual' 데이터 충돌
-- 해결: DROP 후 새 제약 추가 순서 보장 + 기존 individual 데이터 보존

BEGIN;

-- 1. 누락 컬럼 추가 (이미 있으면 무시)
ALTER TABLE user_profiles
  ADD COLUMN IF NOT EXISTS native_lang      TEXT DEFAULT 'ko',
  ADD COLUMN IF NOT EXISTS is_public        BOOLEAN DEFAULT true,
  ADD COLUMN IF NOT EXISTS handle           TEXT,
  ADD COLUMN IF NOT EXISTS lat              FLOAT,
  ADD COLUMN IF NOT EXISTS lng              FLOAT,
  ADD COLUMN IF NOT EXISTS geo_updated_at   TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS extra            JSONB DEFAULT '{}'::jsonb;

-- 2. 기존 entity_type CHECK 제약 제거
ALTER TABLE user_profiles
  DROP CONSTRAINT IF EXISTS user_profiles_entity_type_check;

-- 3. individual + consumer + org + institution 모두 허용하는 새 제약 추가
--    (기존 'individual' 데이터 보존, 신규 'consumer' 타입도 허용)
ALTER TABLE user_profiles
  ADD CONSTRAINT user_profiles_entity_type_check
  CHECK (entity_type IN ('consumer', 'individual', 'org', 'institution'));

-- 4. handle UNIQUE 제약 (없으면 추가)
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

-- 5. 인덱스 추가
CREATE INDEX IF NOT EXISTS idx_up_handle
  ON user_profiles(handle) WHERE handle IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_up_native_lang
  ON user_profiles(native_lang);

CREATE INDEX IF NOT EXISTS idx_up_location
  ON user_profiles(lat, lng)
  WHERE lat IS NOT NULL AND lng IS NOT NULL;

COMMIT;

-- 검증: 현재 entity_type 분포 확인
SELECT entity_type, COUNT(*) as cnt
FROM user_profiles
GROUP BY entity_type
ORDER BY entity_type;

-- 검증: 새로 추가된 컬럼 확인
SELECT column_name, data_type, column_default
FROM information_schema.columns
WHERE table_name = 'user_profiles'
  AND column_name IN ('native_lang','is_public','handle','lat','lng','extra')
ORDER BY column_name;
