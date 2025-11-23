class PriceTrackerJob < ApplicationJob
  queue_as :default
  retry_on StandardError, wait: 5.seconds, attempts: 3

  def perform(ski_resort_id)
    SkiResort.find(ski_resort_id).fetch_prices!
  end
end
