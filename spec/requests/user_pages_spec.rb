require 'spec_helper'

describe "User Pages" do
  
  subject { page }
  
  describe "sign up page" do
    before { visit signup_path }

    it { should have_selector('title', text: "Registro") }
    
    let(:submit) { "Crear cuenta" }

    describe "with invalid info" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      describe "error messages" do
        before { click_button submit }
        it { should have_selector('title', text: "Registro") }
        it { should have_selector('span.error') }
      end
    end

    describe "with valid info" do
      before do
        fill_in "Email",   with: "usuario@ejemplo.com"
        fill_in "Password",   with: "foobar"
        fill_in "Confirmar password",   with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email("usuario@ejemplo.com") }

        it { should have_selector("title") }
        it { should_not have_link('Login', href: login_path) }
        it { should have_link('Salir', href: logout_path) }
        it { should have_link('Perfil', href: perfil_path(user)) }
        it { should have_link('Fotos') }
      end
    end
  end

  describe "show page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('title') }
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      log_in user
      visit edit_user_path(user) 
    end

    describe "page" do
      it { should have_selector('title', text: "Editar") }
      # it { should have_selector('h1', text: ) }
      # it { should have_link('', href: ) }
    end

    describe "with invalid info" do
      before do
        fill_in "Email",   with: "invalido"
        click_button "Finalizar" 
      end

      it { should have_selector('span.error') }
    end

    describe "with valid info" do
      let(:new_email) { "nuevo@email.com" }
      before do
        fill_in "Email",   with: new_email
        click_button "Finalizar"
      end

      # it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Salir', href: logout_path) }
      specify { user.reload.email.should == new_email }
    end
  end

end
