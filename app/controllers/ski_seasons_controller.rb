class SkiSeasonsController < ApplicationController
  def show
    @ski_season = SkiSeason.find_by(slug: params[:slug])
    @ski_passes = @ski_season.ski_passes.for_month(month_filter).includes(:price_entries)
    @ski_pass_prices = @ski_passes.pluck(:valid_on, :current_price_in_chf).to_h

    @selected_date = date_filter
    @selected_ski_pass = @ski_passes.find_by(valid_on: @selected_date)
  end

  private

  def month_filter
    params[:month]&.to_i || date_filter.month
  end

  def date_filter
    filter_date = Date.parse(params[:date]) rescue nil
    if filter_date.present? && @ski_season.period.include?(filter_date)
      filter_date
    elsif params[:month].present?
      @ski_passes.not_in_past.first&.valid_on || @ski_passes.first&.valid_on
    else
      @ski_season.period.include?(Date.today) ? Date.today : @ski_season.start_date
    end
  end
end
