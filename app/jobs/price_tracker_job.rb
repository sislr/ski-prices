class PriceTrackerJob < ApplicationJob
  queue_as :default
  retry_on StandardError, wait: 5.seconds, attempts: 3

  def perform(*args)
    SkiResort.find_each do |ski_resort|
      fetcher = Fetchers::Registry.fetcher_for(ski_resort)
      next unless fetcher

      fetcher.fetch_prices!
    end
  end
end
