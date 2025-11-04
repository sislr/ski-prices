class Fetchers::StMoritz < Fetchers::Base
  def fetch_prices!
    browser, page = open_browser
    traffic = page.network.traffic
    visit_ski_resort_page(page)

    skitickets_availability = extract_skitickets_availability(traffic)

    season = @ski_resort.current_ski_season
    price_entries = map_response_to_price_entries(skitickets_availability, season.start_date, season.end_date)
    create_price_entries!(season, price_entries.compact)

    browser.quit
  end

  private

  TIMEOUT_IN_SECONDS = 20
  def open_browser
    browser = Ferrum::Browser.new(timeout: TIMEOUT_IN_SECONDS, browser_options: { "no-sandbox": nil })
    [ browser, browser.create_page ]
  end

  def visit_ski_resort_page(page)
    page.goto(@ski_resort.booking_url)
    page.network.wait_for_idle
  end

  REQUEST_ENDPOINT = "https://booking.engadin.ch/skitickets/availability"
  def extract_skitickets_availability(traffic)
    availability_request = traffic.find { |request| request.url.include?(REQUEST_ENDPOINT) }

    raise "Request to #{REQUEST_ENDPOINT} not found" unless availability_request
    raise "Empty response" if availability_request.response.nil?

    JSON.parse(availability_request.response.body)
  end

  def map_response_to_price_entries(response, season_start_date, season_end_date)
    response.values.map do |price|
      date_from = Date.parse(price["date_from"])
      date_to = Date.parse(price["date_to"])

      next unless date_from == date_to
      next unless date_from >= season_start_date && date_to <= season_end_date

      {
        valid_on: date_from,
        price_in_chf: price["final_price"].to_i
      }
    end
  end
end
