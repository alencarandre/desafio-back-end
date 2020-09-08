class BucketReaderService < ApplicationService
  def initialize(key)
    @key = key
  end

  def call
    content = bucket_object.body.read
    content.each_line.with_index do |line, index|
      line = strip(line)
      yield line, index + 1 if line.present?
    end
  end

  private

  def bucket_object
    s3_client
      .get_object(
        bucket: bucket_name,
        key: @key
      )
  end

  def bucket_name
    ENV['AWS_BUCKET']
  end

  def s3_client
    Aws::Client.s3
  end

  def strip(line)
    line
      .gsub(/\r\n$/, '')
      .gsub(/\n$/, '')
  end
end
