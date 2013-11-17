require 'spec_helper'

describe "StaticPages" do
  let(:base_title) { 'Ruby on Rails Tutorial Sample App'}
  describe "Home page" do
    it "should have content 'Home'" do
      # # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      # visit static_pages_index_path
      # response.status.should be(200)
      # visit '/static_pages/home'
      visit static_pages_home_path
      page.should have_content('Home')
    end

    it 'should have the correct title' do
      visit static_pages_home_path
      page.should have_title("#{base_title} | Home")
    end
  end

  describe "Help page" do
    it "should have content 'Help'" do
      visit static_pages_help_path
      page.should have_content('Help')
    end

    it 'should have the correct title' do
      visit static_pages_help_path
      page.should have_title("#{base_title} | Help")
    end
  end

  describe "About page" do
    it "should have content 'About Us'" do
      visit static_pages_about_path
      page.should have_content('About Us')
    end

    it 'should have the correct title' do
      visit static_pages_about_path
      page.should have_title("#{base_title} | About Us")
    end
  end

  describe "Contact page" do
    it "should have content 'Contact'" do
      visit static_pages_contact_path
      page.should have_content('Contact')
    end

    it 'should have the correct title' do
      visit static_pages_contact_path
      page.should have_title("#{base_title} | Contact")
    end
  end
end
