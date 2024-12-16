FactoryBot.define do
  factory :brand do
    sequence(:name) { |n| "Brand #{n}" }

    trait :toyota do
      name { 'Toyota' }
    end

    trait :lexus do
      name { 'Lexus' }
    end

    trait :nissan do
      name { 'Nissan' }
    end
  end
end
