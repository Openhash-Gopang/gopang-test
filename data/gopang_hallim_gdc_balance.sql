-- 고팡 한림읍 28개 업체·기관 GDC 초기 잔액 지급
-- fs_ledger.tx_id NOT NULL 제약 대응

BEGIN;

INSERT INTO fs_ledger (
  tx_id, tx_at, guid, direction, amount,
  fs_account, source, memo
)
SELECT
  'init_gdc_' || guid,   -- tx_id: 엔티티별 고유값
  now(),
  guid,
  'credit',
  1000000,
  'bs-cash',
  'manual',
  '테스트용 초기 GDC 잔액 지급'
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
)
ON CONFLICT DO NOTHING;

-- extra.fs 갱신
UPDATE user_profiles
SET extra = jsonb_set(
  COALESCE(extra, '{}'),
  '{fs}',
  '{"bs-cash":1000000,"pl-purchase":0,"pl-revenue":0}'::jsonb
)
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

-- 검증
SELECT COUNT(*) AS gdc_records
FROM fs_ledger
WHERE tx_id LIKE 'init_gdc_%';
-- 기대값: 28
