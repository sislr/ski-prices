class SkiResort < ApplicationRecord
  has_many :ski_seasons, dependent: :destroy

  validates :name, presence: true
  validates :booking_url, presence: true
  validates :fetcher_class_name, presence: true, uniqueness: true

  def self.fetch_all_prices!
    self.find_each do |ski_resort|
      PriceTrackerJob.perform_later(ski_resort.id)
    end
  end

  def fetch_prices!
    "Fetchers::#{fetcher_class_name}".constantize.new(self).fetch_prices!
  end

  def current_ski_season
    ski_seasons.active.first
  end
end
