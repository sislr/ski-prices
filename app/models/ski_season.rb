class SkiSeason < ApplicationRecord
  belongs_to :ski_resort
  has_many :ski_passes, dependent: :destroy

  validates :start_date, presence: true, comparison: { less_than: :end_date }
  validates :end_date, presence: true, comparison: { greater_than: :start_date }
end
