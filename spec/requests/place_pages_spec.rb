require 'spec_helper'

describe "Place Pages" do

  before do
    @user = FactoryGirl.create(:user)
    log_in @user
  end

  subject { page }

  describe "show page" do
    # before { visit  }
  end

  describe "new page" do
    #
    describe "with invalid info" do
      before do
        visit new_place_path
        click_button "Crear lugar"
      end

      it { should have_selector('title', text: "New lugar") }
    end
    describe "with valid info" do
      #
    end
  end

  describe "finder page"do
    before { visit finder_path }

    it { should have_selector('title', text: "Finder") }
  end
end
