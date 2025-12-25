class SkiSeason < ApplicationRecord
  belongs_to :ski_resort
  has_many :ski_passes, dependent: :destroy
  has_many :price_entries, through: :ski_passes

  scope :active, -> { where("start_date <= ? AND end_date >= ?", 2.months.from_now, Date.current) }

  validates :slug, presence: true, uniqueness: true
  validates :start_date, presence: true, comparison: { less_than: :end_date }
  validates :end_date, presence: true, comparison: { greater_than: :start_date }

  def to_param = slug

  def period
    start_date..end_date
  end

  def display_dates
    "#{I18n.l(start_date, format: :short)} – #{I18n.l(end_date, format: :short)}"
  end

  def average_price_in_chf_per_month
    price_entries
      .group("ski_passes.valid_on_year_month")
      .order("ski_passes.valid_on_year_month")
      .average(:price_in_chf)
      .transform_keys { |k| Date.strptime(k, "%Y-%m").strftime("%B") }
      .transform_values(&:round)
  end
end
