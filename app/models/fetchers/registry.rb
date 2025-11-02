class Fetchers::Registry
  FETCHER_CLASSES = {
    "St. Moritz" => Fetchers::StMoritz
  }.freeze

  def self.fetcher_for(ski_resort)
    raise "ski_resort cannot be nil" if ski_resort.nil?

    fetcher_class = FETCHER_CLASSES[ski_resort.name]
    raise "No fetcher found for ski resort: #{ski_resort.name}" unless fetcher_class

    fetcher_class.new(ski_resort)
  end
end
