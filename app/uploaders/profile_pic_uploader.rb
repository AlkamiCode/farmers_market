class ProfilePicUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  process resize_to_fill: [960, 750]

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args)
    ActionController::Base.helpers.asset_path([version_name, random_picture].compact.join('_'))
  end

  def random_picture
    ["farmers/amish-hay.jpg", "farmers/dairy_farm_family.jpg", "farmers/fall_farm_family.jpg",
      "farmers/familyfarms_hay.jpg", "farmers/female_farmer.jpg", "farmers/hispanic_farmer.jpg",
      "farmers/large_family.jpg", "farmers/multi-generation.jpg",
      "farmers/pumkin_farmer.jpg", "farmers/spreading_ladybugs.jpg", "farmers/tractor_family.jpg",
      "farmers/young_farm_family.jpg", "farmers/young_hay_field.jpg"].sample
    end
  end
