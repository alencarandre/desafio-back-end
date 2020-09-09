class MovementsController < ApplicationController
  def index
    @store = Store.find(params[:store_id])
    @movements = MovementByStoreService.(Movement, @store)
  end
end
