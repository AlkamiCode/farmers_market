CarrierWave.configure do |config|


  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog

    config.fog_credentials = {
      provider:                         'AWS',
      region: 'us-west-2',

      aws_access_key_id:     Figaro.env.aws_access_key_id,
      aws_secret_access_key: Figaro.env.aws_secret_access_key
    }
    config.fog_directory = 'alkami-farmers-market'
  end


  config.cache_dir = "#{Rails.root}/tmp/uploads"
end
