class CarSerializer < ActiveModel::Serializer
  attributes :id, :brand, :model, :price, :rank_score, :label
  belongs_to :brand

  def rank_score
    1
  end

  def label
    'perfect_match'
  end
end
