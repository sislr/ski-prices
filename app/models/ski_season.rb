class SkiSeason < ApplicationRecord
  belongs_to :ski_resort
  has_many :ski_passes, dependent: :destroy
  has_many :price_entries, through: :ski_passes

  scope :active, -> { where("start_date <= ? AND end_date >= ?", 2.months.from_now, Date.current) }

  validates :start_date, presence: true, comparison: { less_than: :end_date }
  validates :end_date, presence: true, comparison: { greater_than: :start_date }

  def display_dates
    "#{I18n.l(start_date, format: :short)} – #{I18n.l(end_date, format: :short)}"
  end
end
