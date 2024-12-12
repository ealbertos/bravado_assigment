class Car < ApplicationRecord
  belongs_to :brand

  scope :by_brand_name, lambda { |name|
    joins(:brand).where('brands.name ILIKE ?', "%#{name}%") if name.present?
  }

  scope :by_price_range, ->(min, max) { where(price: min..max) }

  def match_lable
    if user.preferred_brands.include?(brand) && user.preferred_price_range.include?(price)
      'perfect_match'
    elsif user.preferred_brands.include?(brand)
      'good_match'
    else
      'null'
    end
  end
end
