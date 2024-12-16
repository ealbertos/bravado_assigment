FactoryBot.define do
  factory :api_token do
    value { SecureRandom.hex }
  end
end
