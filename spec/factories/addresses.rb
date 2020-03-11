FactoryBot.define do
  factory :address do
    family_name_kanji     {"内山"}
    first_name_kanji      {"立樹"}
    family_name_kana      {"ウチヤマ"}
    first_name_kana       {"タツキ"}
    postal_code           {"216-0006"}
    prefecture_id         {1}
    municipalities        {"川崎市宮前区宮前平"}
    block_number          {"1−10−15"}
    building_name         {"ソーシャルアパートメント宮前平"}
    room_number           {"416"}
    phone_number          {"080-5177-4500"}
    user_id               {1}
  end
end