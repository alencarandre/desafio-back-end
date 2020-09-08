class SqsConsumeService < ApplicationService
  def initialize(queue_url)
    @queue_url = queue_url
  end

  def call
    response = receive_messages
    response.messages.each do |message|
      payload = JSON.parse(message.body)

      yield payload['id'], payload['key']

      delete_message(message.receipt_handle)
    end
  end

  private

  def receive_messages
    sqs_client.receive_message(
      queue_url: @queue_url,
      max_number_of_messages: 10,
      wait_time_seconds: 10
    )
  end

  def delete_message(receipt_handle)
    sqs_client.delete_message({
      queue_url: @queue_url,
      receipt_handle: receipt_handle
    })
  end

  def sqs_client
    Aws::Client.sqs
  end
end
