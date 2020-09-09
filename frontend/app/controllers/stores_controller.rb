class StoresController < ApplicationController
  def index
    @stores = StoreService.call
  end
end
