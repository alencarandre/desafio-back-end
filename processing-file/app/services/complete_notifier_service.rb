class CompleteNotifierService < ApplicationService
  def initialize(processing_id)
    @processing_id = processing_id
  end

  def call
    client.complete(@processing_id)
  end

  private

  def client
    @client = Notifier::Client.new
  end
end
