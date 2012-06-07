# == Schema Information
#
# Table name: places
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  coord      :spatial({:no_co
#

require 'spec_helper'

describe Place do
  
  before do
    @place = Place.new(name: "Bar")
    @place.lat = 1.0
    @place.lng = 1.0
  end

  subject { @place }
  
  it { should respond_to(:name) }
  it { should respond_to(:coord) }
  it { should respond_to(:lat) }
  it { should respond_to(:lng) }

  it { should be_valid }

  
end
