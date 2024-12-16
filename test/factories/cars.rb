FactoryBot.define do
  factory :car do
    sequence(:model) { |n| "Car #{n}" }
    price { 10_000 }

    trait :sentra do
      model { 'Sentra' }
      price { 35_000 }
      association :brand, factory: %i[brand nissan]
    end

    trait :versa do
      model { 'Versa' }
      price { 30_000 }
      association :brand, factory: %i[brand nissan]
    end

    trait :camry do
      model { 'Camry' }
      price { 45_000 }
      association :brand, factory: %i[brand toyota]
    end

    trait :corolla do
      model { 'Corolla' }
      price { 40_000 }
      association :brand, factory: %i[brand toyota]
    end

    trait :ls do
      model { 'LS' }
      price { 55_000 }
      association :brand, factory: %i[brand lexus]
    end

    trait :is do
      model { 'IS' }
      price { 50_000 }
      association :brand, factory: %i[brand lexus]
    end
  end
end
