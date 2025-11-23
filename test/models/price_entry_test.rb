require "test_helper"

class PriceEntryTest < ActiveSupport::TestCase
  test "price entry cannot be created for date in the past" do
    pass = ski_passes(:st_moritz_christmas_day_pass_adult)
    pass.valid_on = 1.day.ago

    price_entry = PriceEntry.new(ski_pass: pass, price_in_chf: 100)
    assert price_entry.invalid?
  end
end
