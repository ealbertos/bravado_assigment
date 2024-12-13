class CarSerializer < ActiveModel::Serializer
  attributes :id, :brand, :model, :price, :rank_score, :label
  belongs_to :brand
end
