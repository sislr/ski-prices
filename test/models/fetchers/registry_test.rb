# frozen_string_literal: true

require "test_helper"

class Fetchers::RegistryTest < ActiveSupport::TestCase
  test "fetcher_for" do
    ski_resort = ski_resorts(:st_moritz)
    fetcher = Fetchers::Registry.fetcher_for(ski_resort)

    assert_instance_of Fetchers::StMoritz, fetcher

    ski_resort.name = "Unknown Resort"
    assert_raises(RuntimeError, "No fetcher found for ski resort: Unknown Resort") do
      Fetchers::Registry.fetcher_for(ski_resort)
    end

    assert_raises(RuntimeError, "ski_resort cannot be nil") do
      Fetchers::Registry.fetcher_for(nil)
    end
  end
end
