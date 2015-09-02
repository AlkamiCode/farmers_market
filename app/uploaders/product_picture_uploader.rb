class ProductPictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  process resize_to_fill: [960, 750]
  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
