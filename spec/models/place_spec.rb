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
    @place = Place.new(name: "Bar", latlng: 'POINT(1.0 1.0)' )
  end

  subject { @place }
  
  it { should respond_to(:name) }
  it { should respond_to(:latlng) }

  it { should be_valid }

  
end
