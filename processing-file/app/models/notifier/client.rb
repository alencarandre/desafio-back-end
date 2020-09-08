class Notifier::Client
  FRONTEND_ENDPOINT = ENV['FRONTEND_ENDPOINT']

  def complete(processing_id)
    send("/cnab_files/#{processing_id}/completed")
  end

  private

  def endpoint
    FRONTEND_ENDPOINT
  end

  def send(path)
    RestClient.patch("#{endpoint}#{path}", nil)
  end
end
