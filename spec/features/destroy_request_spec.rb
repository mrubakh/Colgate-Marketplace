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
       @u1 = User.create!(name: "Mark", email: "mrubakh@colgate.edu", payment: "venmo", password: "abcdef")
       @u2 = User.create!(name: "Amy", email: "amy@colgate.edu", payment: "cash", password: "ghijkl")
       Item.create!(name: "Table", price: 13.13, description: "Surface with 4 legs. It is a table.", listed: true, status: "available", deliverable: true, user_id:1)
       Item.create!(name: "Muffin Tin", price: 2.00, description: "Tin for making muffins.", listed: true, status: "available", deliverable: true, user_id: @u2.id)
       Item.create!(name: "Microphone", price: 15.99, description: "Great for singing.", listed: true, status: "available", deliverable: true, user_id: @u2.id)
       visit "/items"
    end

   it "should allow seller to edit the item" do
    login
    click_link("Table")
    expect(page).to have_link("Delete item")
    click_link("Delete item")
    expect(page).to have_content("Table deleted.")
  end
 end
  