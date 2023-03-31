class PostImageUploader < CarrierWave::Uploader::Base
  
  #開発環境ごとに保存先を変える記述方法
  if Rails.env.development?
    storage :file
  elsif Rails.env.test?
    storage :file
  else
    storage :fog
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    'post_no_image.png'
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

end
