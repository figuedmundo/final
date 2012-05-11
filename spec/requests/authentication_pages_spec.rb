require 'spec_helper'

describe "Authentication" do
  subject { page }
  
  describe "login page" do
    before { visit login_path }

    it { should have_selector('title', text: "Login") }
    
    describe "with invalid info" do
      before { click_button "Entrar" }

      it { should have_selector('title', text: "Login") }
      # it { should have_content('') }
    end

    describe "with valid info" do
      let(:user) { FactoryGirl.create(:user) }
      before { log_in user }

      it { should have_selector('title', text: user.email) }
      it { should have_link("Salir", href: logout_path) }
      it { should_not have_link('Login', href: login_path) }
      # it { should have_link('', href: ) }
      describe "followed by logout" do
        before { click_link 'Salir' }
        it { should have_link('Login', href: login_path) }
      end
    end
  end
end
