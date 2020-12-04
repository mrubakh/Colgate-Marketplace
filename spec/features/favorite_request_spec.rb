require 'simplecov'
require 'rails_helper'
require 'login_helper'
require 'capybara/rails'


RSpec.describe "index page", type: :feature do
    OmniAuth.config.test_mode = true
    before :all do
            #Mock user login with SSO
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      :provider => 'google_oauth2',
      :uid => '1',
      :info => {
        :email => "test@colgate.edu"
      },
      :credentials => {
        :token => "token",
        :secret => "secret"
      }})
    end
    before :each do
        
        @u1 = User.create!(name: "nj", email: "nj@colgate.edu", password: "colgate")
        Item.create!(name: "Table", price: 13.13, description: "Surface with 4 legs. It is a table.", listed: true, status: "available", deliverable: true, user_id: @u1.id)
        Item.create!(name: "Muffin Tin", price: 2.00, description: "Tin for making muffins.", listed: true, status: "available", deliverable: true, user_id: @u1.id)
        Item.create!(name: "Microphone", price: 15.99, description: "Great for singing.", listed: true, status: "available", deliverable: true, user_id: @u1.id)
        visit "/items"
    end
    
    
    
    it "should not be able to favorite item when not logged in" do
        visit "items/1"
        expect(page).not_to have_content("Favorite")
    end
    
     it "should be able to favorite an item when logged in" do
        login
        visit "items/1"
        expect(page).to have_css('.favBtn')
        find(".favBtn").find("input").click()
        expect(page).to have_content("Successfully Favorited.")
    end
    
    it "should be able to un favorite an item when logged in" do
        login
        visit "items/1"
        expect(page).to have_css('.favBtn')
        find(".favBtn").find("input").click()
        expect(page).to have_content("Successfully Favorited.")
        
        find(".favBtn").find("input").click()
        expect(page).to have_content("Successfully Unfavorited.")
    end
    
    
    
end