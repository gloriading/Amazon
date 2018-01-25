CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'] || '',
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] || '',
    region: 'us-west-2' # from region i picked
  }

  config.fog_directory = 'amazon-jan' # AWS S3 Bucket Name
  config.fog_public = false
  config.fog_attributes = {
    'Cache-Control' => "max-age=#{365.day.to_i}"
  }
end
