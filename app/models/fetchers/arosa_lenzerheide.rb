class Fetchers::ArosaLenzerheide < Fetchers::Base
  def fetch_prices!
    price_entries = []
    months_per_year.each do |year, months|
      months.each do |month|
        price_entries.concat(fetch_prices_per(year, month) || [])
      end
    end

    create_price_entries!(@ski_resort.current_ski_season, price_entries.compact)
  end

  private

  def months_per_year # => { 2025: [11, 12], 2026: [1, 2, 3, 4] }
    current_season = @ski_resort.current_ski_season
    current_month = current_season.start_date.before?(Date.today) ? Date.today.month : current_season.start_date.month
    current_year = current_season.start_date.before?(Date.today) ? Date.today.year : current_season.start_date.year
    end_month = current_season.end_date.month
    end_year = current_season.end_date.year

    months_by_year = {}
    year = current_year
    month = current_month
    while year < end_year || (year == end_year && month <= end_month)
      months_by_year[year] ||= []
      months_by_year[year] << month

      month += 1
      if month > 12
        month = 1
        year += 1
      end
    end
    months_by_year
  end

  SKI_TICKET_ENDPOINT = "https://shop.arosalenzerheide.swiss/ajax/ticket-day-price/127?ticketId=skid-aldprod_35c48fcf-c593-7cba-4472-b9e6a271c54b"
  def fetch_prices_per(year, month)
    response = perform_get_request("#{SKI_TICKET_ENDPOINT}&year=#{year}&month=#{month}")

    return nil unless response.is_a?(Net::HTTPSuccess)

    prices = JSON.parse(response.body)["dates"]["dates"]
    prices.map do |price|
      next if price["isDisabled"] == "1"

      {
        valid_on: Date.parse(price["date"]),
        price_in_chf: price["price"].to_i
      }
    end.compact
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
