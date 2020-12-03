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
       Item.create!(name: "Chapstick", price: 1.99, description: "Lightly used.", listed: false, status: "available", deliverable: true, user_id: 1)
       visit "/items"
    end

   it "should allow seller to edit the item" do
    login
    click_link("Table")
    expect(page).to have_link("Unlist item")
    click_link("Unlist item")
    expect(page).to have_content("Table unlisted.")
  end
  
  it "should let user relist their unlisted items" do
    login 
    visit user_path(1)
    click_link("Chapstick")
    expect(page).to have_link("Relist item")
    click_link "Relist item"
    expect(page).to have_content("Chapstick relisted.")
  end
  
  it "should throw error messages for failed unlist" do
    login 
    click_link("Table")
    expect(page).to have_link("Unlist item")
    expect_any_instance_of(Item).to receive(:update_attribute).and_return(false)
    click_link "Unlist item"
    expect(page).to have_content("Table could not be unlisted")
  end 
  
  it "should throw error messages for failed relist" do
    login 
    visit user_path(1)
    click_link("Chapstick")
    expect(page).to have_link("Relist item")
    expect_any_instance_of(Item).to receive(:update_attribute).and_return(false)
    click_link "Relist item"
    expect(page).to have_content("Chapstick could not be relisted")
  end 
 end
 
  