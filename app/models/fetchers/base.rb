class Fetchers::Base
  def initialize(ski_resort)
    @ski_resort = ski_resort
  end

  def fetch_prices!
    raise NotImplementedError
  end

  private

  def create_price_entries!(season, mapped_prices)
    mapped_prices.each do |price|
      pass = season.ski_passes.find_or_create_by!(valid_on: price[:valid_on], age_group: "adult")
      pass.price_entries.create!(price_in_chf: price[:price_in_chf])
    end
  end
end
