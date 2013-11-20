require 'spec_helper'

describe "StaticPages" do
  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', :text => heading) }
    it { should have_title(full_title(page_title)) }
  end


  describe "Home page" do
    before { visit root_path }
    let(:heading) { 'Bonjour B!TC3S!! Welcome to the best Rails app in the universe!!!' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_title("| Home") }
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading) { 'Help' }
    let(:page_title) { 'Help' }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:heading) { 'About Us' }
    let(:page_title) { 'About Us' }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading) { 'Contact' }
    let(:page_title) { 'Contact' }

    it_should_behave_like "all static pages"
  end

  it 'should have the right links on the layout' do
    visit root_path
    click_link "About"
    current_path.should eq(about_path)
    should have_selector('h1', :text => 'About Us')
    click_link "Contact"
    current_path.should eq(contact_path)
    should have_selector('h1', :text => 'Contact')
    click_link "Help"
    current_path.should eq(help_path)
    should have_selector('h1', :text => 'Help')
    click_link "sample app"
    current_path.should eq(root_path)
    should have_selector('h1', :text => 'Bonjour B!TC3S!! Welcome to the best Rails app in the universe!!!')
  end
end
