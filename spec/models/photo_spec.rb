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

require 'spec_helper'

describe Photo do

  let(:user) { FactoryGirl.create(:user) }
  let(:place) { FactoryGirl.create(:place, user: user) }
  before do
    @photo = place.photos.build(desc: "a new photo")
    @photo.user = user
  end

  subject { @photo }
  
  it { should respond_to(:desc) }
  it { should respond_to(:image) }
  it { should respond_to(:place) }
  it { should respond_to(:user) }

  it { should be_valid }

end
