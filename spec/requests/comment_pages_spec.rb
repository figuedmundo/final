require 'spec_helper'

describe "Comment Pages" do
  
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  before { log_in user }

  describe "comment creation" do
    before { visit user_path(user) }

    describe "with invalid info" do
      it "should not create a commet" do
        expect { click_button "Compartir" }.should_not change(Comment, :count)
      end
      describe "error message" do
        before { click_button "Compartir" }
        it { should have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid info" do
      before do
        fill_in "comment_content",   with: "Lorem ipsun"        
      end

      it "should create a comment" do
        expect { click_button "Compartir" }.should change(Comment, :count).by(1)
      end
    end
  end
end
