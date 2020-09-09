class SaveRecord::Client
  SAVE_RECORD_ENDPOINT = ENV['SAVE_RECORD_ENDPOINT']

  def stores
    JSON.parse(get('/stores').body)
  end

  def movements(store_id)
    JSON.parse(get("/stores/#{store_id}/movements").body)
  end

  private

  def get(path)
    RestClient.get("#{SAVE_RECORD_ENDPOINT}#{path}")
  end
end
