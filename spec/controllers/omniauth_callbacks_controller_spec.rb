require 'rails_helper'
require 'login_helper'
require 'capybara/rails'
require 'simplecov'
SimpleCov.start
#As a user, so that I can be assured only Colgate-affiliates can use the marketplace, I want only colgate emails to be able to list items.

describe OmniauthCallbacksController, type: :feature do
    OmniAuth.config.test_mode = true

it 'should let me log in as aknox@colgate.edu' do 
    login
    u = User.find(1)
    expect(u.email).to eq("test@colgate.edu") #hits successful login path!
    visit root_path
    expect(page).to have_content("Logged in as test@colgate.edu")
    expect(page).to have_content("List an item")
end

it 'should not let me log in as test@test.com' do
    #I know this is ugly, but I wasn't sure how to change email to non-colgate from rails_helper.
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      :provider => 'google_oauth2',
      :uid => '1',
      :info => {
        :email => "test@testcom"
      },
      :credentials => {
        :token => "token",
        :secret => "secret"
      }})
      
    login
    expect(page).to have_content("Please use a @colgate.edu email address to log in.")
    expect(page).to have_no_content("List an item")
end



 #OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials

end