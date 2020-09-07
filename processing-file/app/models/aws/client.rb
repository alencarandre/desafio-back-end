class Aws::Client
  def self.s3
    Aws::S3::Client.new(
      credentials: self.credentials,
      region: self.region,
      force_path_style: self.force_path_style,
      endpoint: self.endpoint,
    )
  end

  def self.sqs
    Aws::SQS::Client.new(
      access_key_id: self.access_key_id,
      secret_access_key: self.secret_access_key,
      endpoint: self.endpoint,
      region: self.region,
    )
  end

  private

  def self.credentials
    Aws::Credentials.new(self.access_key_id, self.secret_access_key)
  end

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

  def self.force_path_style
    true
  end
end
