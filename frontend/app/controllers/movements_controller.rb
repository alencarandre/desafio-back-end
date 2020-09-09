class MovementsController < ApplicationController
  def index
    @store = MovementService.(params[:store_id])
  end
end
