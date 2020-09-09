class StoresController < ApplicationController
  def index
    @stores = Store.summary
  end
end
