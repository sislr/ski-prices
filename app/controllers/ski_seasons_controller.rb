class SkiSeasonsController < ApplicationController
  def show
    @ski_season = SkiSeason.find_by(slug: params[:slug])
  end
end
