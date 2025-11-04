class SkiResortsController < ApplicationController
  def index
    @ski_resorts = SkiResort.order(:name)
  end
end
