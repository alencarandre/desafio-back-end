class StoreService < ApplicationService
  def call
    client.stores
  end

  private

  def client
    SaveRecord::Client.new
  end
end
