require 'simplecov'

Given('I am logged in') do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
        :provider => 'google_oauth2',
        :uid => '1',
        :info => {
            :email => "test@colgate.edu"
        },
        :credentials => {
            :token => "token",
            :secret => "secret"
        }
    })
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
    visit root_path
    click_link 'Log in with Google SSO'
end

Then('I should be on the new item page') do
  expect(page).to have_current_path('/items/new')
end

When('I fill in the following:') do |table|
    table.rows.each do |a|
        fill_in a[0], with: a[1]
    end
end

Then('I should be on the show item {string} page') do |string|
  expect(page).to have_current_path('/items/'+string)
end

Then('I should be on the edit item {string} page') do |string|
  expect(page).to have_current_path('/items/'+string+"/edit")
end

Then('I should be on the show updated spoon page') do #too specific, refactor
    expect(page).to have_current_path('/items/4?notice=gold+spoon+updated.')
end
