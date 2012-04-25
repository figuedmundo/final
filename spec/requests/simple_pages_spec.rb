require 'spec_helper'

describe "Simple Pages" do
  
  subject { page }
  
  describe "home page" do
    before { visit root_path }

    it { should have_selector("title", text: "Home") }
    it { should have_link('Registrate', href: signup_path ) }
  end
end
