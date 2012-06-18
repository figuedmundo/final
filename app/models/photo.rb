class Photo < ActiveRecord::Base
  attr_accessible :desc, :image
  belongs_to :place
  belongs_to :user
  mount_uploader :image, ImageUploader



end
