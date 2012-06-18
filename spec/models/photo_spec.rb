require 'spec_helper'

describe Photo do

  let(:user) { FactoryGirl.create(:user) }
  let(:place) { FactoryGirl.create(:place, user: user) }
  before do
    @photo = place.photos.build
    @photo.user = user
  end

  subject { @photo }
  
  it { should respond_to(:desc) }
  it { should respond_to(:image) }
  it { should respond_to(:place) }
  it { should respond_to(:user) }

  it { should be_valid }

end
