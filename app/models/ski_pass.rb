class SkiPass < ApplicationRecord
  belongs_to :ski_season
  has_many :price_entries, dependent: :destroy

  AGE_GROUPS = %w[child youth adult].freeze
  enum :age_group, AGE_GROUPS.index_with(&:itself), validate: true

  validates :valid_on, presence: true
end
