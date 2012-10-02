# == Schema Information
#
# Table name: photos
#
#  id         :integer         not null, primary key
#  desc       :string(255)
#  place_id   :integer
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  image      :string(255)
#

class Photo < ActiveRecord::Base
  attr_accessible :desc, :image
  belongs_to :place
  belongs_to :user
  mount_uploader :image, ImageUploader

  validates :image, presence: { message: "Es necesaria una foto"}


end
