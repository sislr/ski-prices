require "test_helper"
require "active_job/test_helper"
require "minitest/mock"

class SkiResortTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  test "fetch_prices!" do
    ski_resort = ski_resorts(:st_moritz)

    mock_fetcher = Minitest::Mock.new
    mock_fetcher.expect(:fetch_prices!, true)

    Fetchers::StMoritz.stub(:new, mock_fetcher) do
      assert ski_resort.fetch_prices!
    end

    mock_fetcher.verify
  end

  test "fetch_prices! with unknown fetcher class" do
    ski_resort = ski_resorts(:st_moritz)
    ski_resort.fetcher_class_name = "UnknownFetcher"

    assert_nothing_raised do
      ski_resort.fetch_prices!
    end
  end

  test "fetch_all_prices! enqueues a job" do
    ski_resort = ski_resorts(:st_moritz)
    assert_enqueued_with(job: PriceTrackerJob, args: [ ski_resort.id ]) do
      SkiResort.fetch_all_prices!
    end
  end
end
