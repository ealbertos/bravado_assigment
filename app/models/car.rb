class Car < ApplicationRecord
  belongs_to :brand
  attr_accessor :label, :rank_score

  scope :by_brand_name, lambda { |name|
    joins(:brand).where('brands.name ILIKE ?', "%#{name}%") if name.present?
  }

  scope :by_price_range, ->(min, max) { where(price: min..max) }
end
