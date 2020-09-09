class MovementByStoreService < ApplicationService
  def initialize(model, store)
    @model = model
    @store = store
  end

  def call
    @model
      .includes(:transaction_type)
      .where(store_id: @store.id)
      .order(:transaction_date)
  end
end
