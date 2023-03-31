unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AKIASM4ZUJ5HHUERBP7U',
      aws_secret_access_key: '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',
      region: 'ap-northeast-1'
    }

    config.fog_directory  = 'whisker-backet'
    config.cache_storage = :fog
  end
end