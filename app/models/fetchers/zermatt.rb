class Fetchers::Zermatt < Fetchers::Base
  def fetch_prices!
    price_entries = fetch_ski_passes.flatten.map do |ski_pass|
      fetch_price_for_date(ski_pass)
    end
    create_price_entries!(@ski_resort.current_ski_season, price_entries.compact)
  end

  private

  CALENDAR_ENDPOINT = "https://www.matterhornparadise.ch/de/shop/ticket/calendar-dates?ticketId=1501805&isMobile=false&shownStartYear=2025&shownStartMonth=11&shownEndYear=2026&shownEndMonth=5"

  def fetch_ski_passes
    response = perform_get_request(CALENDAR_ENDPOINT)

    return [] unless response.is_a?(Net::HTTPSuccess)

    json_body = JSON.parse(response.body)
    json_body["calendarDates"].pluck("dates")
  end

  PRICE_BASE_ENDPOINT = "https://www.matterhornparadise.ch/de/shop/ticket/price?ticketId=1501805"
  def fetch_price_for_date(ski_pass)
    return if ski_pass["disabled"] == true

    response = perform_get_request("#{PRICE_BASE_ENDPOINT}&selectedDateStart=#{ski_pass["date"]}")

    return nil unless response.is_a?(Net::HTTPSuccess)

    price = JSON.parse(response.body)

    return nil unless price["success"] == true

    {
      valid_on: Date.parse(ski_pass["date"]),
      price_in_chf: price["data"]["pricePerAdult"].to_i
    }
  end

  def perform_get_request(endpoint)
    request = Net::HTTP::Get.new(endpoint)
    uri = URI(endpoint)
    http = Net::HTTP.new(uri.hostname, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.request(request)
  end
end
