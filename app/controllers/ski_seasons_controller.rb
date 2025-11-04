class SkiSeasonsController < ApplicationController
  def show
    @ski_season = SkiSeason.find(params[:id])
  end
end
