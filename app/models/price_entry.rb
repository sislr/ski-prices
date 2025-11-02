class PriceEntry < ApplicationRecord
  belongs_to :ski_pass

  validates :price_in_chf, presence: true, numericality: { greater_than: 0 }
end
