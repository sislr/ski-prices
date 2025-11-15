class PriceEntry < ApplicationRecord
  belongs_to :ski_pass

  scope :ordered_by_date, -> { order(created_at: :asc) }

  validates :price_in_chf, presence: true, numericality: { greater_than: 0 }
end
