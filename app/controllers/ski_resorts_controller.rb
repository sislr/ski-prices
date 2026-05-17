class SkiResortsController < ApplicationController
  def index
    @active_seasons_by_resort = SkiSeason.active
      .includes(:ski_resort, :ski_passes)
      .joins(:ski_resort)
      .order("ski_resorts.name ASC, ski_seasons.start_date ASC")
      .map { |season| [ season.ski_resort, season ] }

    @past_seasons_by_year = SkiSeason.past
      .includes(:ski_resort)
      .joins(:ski_resort)
      .order("ski_seasons.end_date DESC, ski_resorts.name ASC")
      .group_by { |season| "#{season.start_date.year}/#{season.end_date.year.to_s[-2..]}" }
  end
end
