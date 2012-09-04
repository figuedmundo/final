# == Schema Information
#
# Table name: type_places
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe TypePlace do

  before do
    @type_place = TypePlace.new( name: "Fotocopiadora" )
  end

  subject { @type_place }

  it { should respond_to(:name) }

  it { should be_valid }

  describe "name downcase" do
    before { @type_place.name = "fotocopiadora" }
    it { should be_valid }
  end  
end
