require 'spec_helper'

describe "StaticPages" do
  let(:base_title) { 'Ruby on Rails Tutorial Sample App'}
  describe "Home page" do
    it "should have content 'Home'" do
      # # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit home_path
      page.should have_content('Home')
    end

    it 'should have the correct title' do
      visit home_path
      page.should have_title("#{base_title}")
    end

    it 'should not have Home in title' do
      visit home_path
      page.should_not have_title("| Home")
    end
  end

  describe "Help page" do
    it "should have content 'Help'" do
      visit help_path
      page.should have_content('Help')
    end

    it 'should have the correct title' do
      visit help_path
      page.should have_title("#{base_title} | Help")
    end
  end

  describe "About page" do
    it "should have content 'About Us'" do
      visit about_path
      page.should have_content('About Us')
    end

    it 'should have the correct title' do
      visit about_path
      page.should have_title("#{base_title} | About Us")
    end
  end

  describe "Contact page" do
    it "should have content 'Contact'" do
      visit contact_path
      page.should have_content('Contact')
    end

    it 'should have the correct title' do
      visit contact_path
      page.should have_title("#{base_title} | Contact")
    end
  end
end
