class SkiPass < ApplicationRecord
  belongs_to :ski_season
  has_many :price_entries, dependent: :destroy

  scope :for_month, ->(month) { where(month: month).order(:valid_on) }

  AGE_GROUPS = %w[child youth adult].freeze
  enum :age_group, AGE_GROUPS.index_with(&:itself), validate: true

  validates :valid_on, presence: true, uniqueness: { scope: [ :ski_season_id, :age_group ] }
  validate :valid_on_is_within_ski_season

  def current_price_in_chf
    price_entries.ordered_by_date.last&.price_in_chf
  end

  private

  def valid_on_is_within_ski_season
    return unless ski_season && valid_on

    if valid_on < ski_season.start_date || valid_on > ski_season.end_date
      errors.add(:valid_on, "must be within the ski season dates")
    end
  end
end
