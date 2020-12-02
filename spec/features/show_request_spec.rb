require 'rails_helper'
require 'login_helper'
require 'capybara/rails'

RSpec.describe "index page", type: :feature do
 OmniAuth.config.test_mode = true
  before :all do 
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
    :provider => 'google_oauth2',
    :uid => '1',
    :info => {
      :email => "mrubakh@colgate.edu"
    },
    :credentials => {
      :token => "token",
      :secret => "secret"
    }})
  end
  before :each do
   @u2 = User.create!(name: "Amy", email: "amy@colgate.edu", payment: "cash", password: "ghijkl")
   Item.create!(name: "Table", price: 13.13, description: "Surface with 4 legs. It is a table.", listed: true, status: "available", deliverable: true, user_id:1)
   Item.create!(name: "Muffin Tin", price: 2.00, description: "Tin for making muffins.", listed: true, status: "available", deliverable: true, user_id: @u2.id)
   Item.create!(name: "Microphone", price: 15.99, description: "Great for singing.", listed: true, status: "available", deliverable: true, user_id: @u2.id)
   visit "/items"
  end

  it "should have links from each item name to 'show' pages" do
    expect(page).to have_link("Table")
    expect(page).to have_link("Muffin Tin")
  end

  it "show link for item and should show details for the items" do
    click_link("Table")
    expect(page).to have_link("Back to item list")
    expect(page).to have_content("Table")
    expect(page).to have_content("Surface with 4 legs. It is a table.")
    expect(page).to have_content("13.13")
    expect(page).to have_content("available")
  end
  
  it "should show an error message when a non-logged in user attempts to contact seller" do 
    click_link("Table")
    expect(page).to have_link("Contact seller")
    click_link("Contact seller")
    expect(page).to have_content("Need to be logged in to contact seller")
  end
  
  it "should send email when user clicks to contact seller" do 
    login
    click_link("Table")
    expect(page).to have_link("Contact seller")
    click_link("Contact seller")
    expect(page).to have_content("Email has been sent.")
  end
end
