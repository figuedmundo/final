# == Schema Information
#
# Table name: places
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  coord      :spatial({:no_co
#  desc       :string(255)
#  address    :string(255)
#  user_id    :integer
#

require 'spec_helper'

describe Place do
  
  let!(:user) { FactoryGirl.create(:user) }
  let(:type_place) { FactoryGirl.create(:type_place) }

  before do
    @place = user.places.build(name: "Bar", address: "Jordan y Calama 1456", desc: "Ipsun Loren")
    @place.lat = 1.0
    @place.lon = 1.0
    @place.type_place = type_place
  end

  subject { @place }
  
  it { should respond_to(:name) }
  it { should respond_to(:coord) }
  it { should respond_to(:lat) }
  it { should respond_to(:lon) }
  it { should respond_to(:address) }
  it { should respond_to(:desc) }
  it { should respond_to(:user) }
  it { should respond_to(:photos) }
  it { should respond_to(:type_place) }



  it { should be_valid }

  describe "when address is too long" do
    before { @place.address = "a"*36 }
    it { should_not be_valid }
  end
  
  describe "when desc is too long" do
    before { @place.address = "a"*255 }
    it { should_not be_valid }
  end

  describe "type place must be present" do
    before { @place.type_place = nil }
    it { should_not be_valid }
  end

end
