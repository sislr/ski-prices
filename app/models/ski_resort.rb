class SkiResort < ApplicationRecord
  has_many :ski_seasons, dependent: :destroy

  validates :name, presence: true
  validates :booking_url, presence: true
end
