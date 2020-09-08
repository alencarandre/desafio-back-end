class Aws::Client
  def self.sqs
    Aws::SQS::Client.new(
      access_key_id: self.access_key_id,
      secret_access_key: self.secret_access_key,
      endpoint: self.endpoint,
      region: self.region,
    )
  end

  private

  def self.access_key_id
    ENV["AWS_ACCESS_KEY_ID"]
  end

  def self.secret_access_key
    ENV["AWS_SECRET_ACCESS_KEY"]
  end

  def self.region
    ENV["AWS_REGION"]
  end

  def self.endpoint
    ENV["AWS_ENDPOINT"]
  end
end
