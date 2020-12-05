require 'simplecov'
require 'login_helper'
require 'rails_helper'

RSpec.describe UsersController, type: :feature do
    
      it 'should let me edit/update my profile' do
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
      login 
      expect(page).to have_content("Logged in as test@colgate.edu")
      expect(page).to have_content("View profile")
      visit '/users/1'
      expect(page).to have_content("Edit profile")
      visit '/users/1/edit'
      fill_in "Name", with: "Allegra"
      fill_in "Payment", with: "Prefers cash"
      click_button "Save User"
      expect(page).to have_content("Logged in as Allegra.")
  end
  
  it "should not let me change my email" do 
      login 
      visit '/users/1/edit'
      expect_any_instance_of(User).to receive(:update_attributes).and_return(false)
      click_button "Save User"
      expect(page).to have_content("Did not update successfully")
  end
  it "should not let me edit someone else's profile" do
      login 
      u = User.create!(name: "Alex", email: "alex@colgate.edu", payment: "cash", password: "password")
      visit edit_user_path(u.id)
      expect(page).to have_content("You can only edit your own profile")
      
      visit user_path(u.id)
      expect(page).not_to have_content("Edit profile")
  end
end
