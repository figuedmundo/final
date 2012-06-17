# == Schema Information
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  content    :text
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  place_id   :integer
#

require 'spec_helper'

describe Comment do
  
  let(:user) { FactoryGirl.create(:user, email: "user@ejem.com") }
  let(:place) { FactoryGirl.create(:place) }
  before do
    @comment = place.comments.build(content: "Lorem ipsun")
    @comment.user = user
  end

  subject { @comment }
  
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:place) }

  its(:user) { should == user }

  it { should be_valid }

  describe "when user id is not preset" do
    before { @comment.user_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Comment.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "with blank content" do
    before { @comment.content = " " }
    it { should_not be_valid }
  end

  describe "with a too long content" do
    before { @comment.content = "a"*2001 }
    it { should_not be_valid }
  end
end
