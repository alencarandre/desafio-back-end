class MovementService < ApplicationService
  def initialize(service_id)
    @service_id = service_id
  end

  def call
    client.movements(@service_id)
  end

  private

  def client
    @@client = SaveRecord::Client.new
  end
end
