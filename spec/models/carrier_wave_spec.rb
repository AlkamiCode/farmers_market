require 'carrierwave/test/matchers'
describe ProfilePicUploader do
  include CarrierWave::Test::Matchers

  before do
    @store = Store.create!(farm_name: "Johnson Farm",
    facebook_url: "facebook.com",
    twitter_url: "twitter.com",
    instagram_url: "instagram.com",
    description: "this is a nice farm",
    url: "johnson-farm")
    ProfilePicUploader.enable_processing = true
    @uploader = ProfilePicUploader.new(@store, :photo_url)
    File.open("spec/fixtures/amish-hay.jpg") do |f|
      @uploader.store!(f)
    end
  end

  after do
    ProfilePicUploader.enable_processing = false
    @uploader.remove!
  end

  context 'the thumb version' do
    it "should scale down a landscape image to be exactly 960 by 750 pixels" do
      @uploader.should have_dimensions(960, 750)
    end
  end
end
