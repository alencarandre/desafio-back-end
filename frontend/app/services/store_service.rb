class StoreService < ApplicationService
  def call
    client.stores
  end

  private

  def client
    @@client = SaveRecord::Client.new
  end
end
