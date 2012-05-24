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

      # it { should have_selector('title', text: user.email) }
      it { should have_link("Salir", href: logout_path) }
      it { should_not have_link('Login', href: login_path) }
      # it { should have_link('', href: ) }
      describe "followed by logout" do
        before { click_link 'Salir' }
        it { should have_link('Login', href: login_path) }
      end
    end
  end

  describe "authorization" do

    describe "for non loged in users" do
      let(:user) { FactoryGirl.create(:user) }  

      describe "when attemping to visit a protected page | friendly forwading" do
        before do
          visit edit_user_path(user)
          fill_in "Email",   with: user.email
          fill_in "Password",   with: user.password
          click_button "Entrar"
        end

        it { should have_selector('title', text: "Editar") }
      end

      describe "in the users controller" do
        
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: "Login") }
        end

        describe "submitting the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(login_path) }
        end
      end

      describe "in the comments controller" do
        describe "submitting  to the create action" do
          before { post comments_path }
          specify { response.should redirect_to(login_path) }
        end
        describe "submitting  to the destroy action" do
          before { delete comment_path(FactoryGirl.create(:comment)) }
          specify { response.should redirect_to(login_path) }
        end
      end

      describe "the index action /users " do
        before { visit users_path }
        it { should have_selector('title', text: "Login") }
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@user.com") }
      before { log_in user }

      describe "visiting the edit page for wrong user" do
        before { visit edit_user_path(wrong_user) }

        it { should_not have_selector('title', text: "Editar") }
      end

      describe "submitting a PUT request to update action from wrong user" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path)}
      end
    end
  end
end
