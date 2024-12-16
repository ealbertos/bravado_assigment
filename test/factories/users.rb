FactoryBot.define do
  factory :user do
    email { 'test@test.com' }
    preferred_price_range { (35_000..50_000) }
  end
end
