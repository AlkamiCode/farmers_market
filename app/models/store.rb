class Store < ActiveRecord::Base
  belongs_to :user
  has_many :products
  has_many :category_stores
  has_many :categories, through: :category_stores
  mount_uploader :photo_url, ProfilePicUploader
  validates :farm_name, presence: true, uniqueness: true
  validates :url, uniqueness: true
  before_validation :generate_url


  def generate_url
    self.url = farm_name.parameterize
  end

  def to_param
    url
  end

end
