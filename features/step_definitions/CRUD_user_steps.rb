


require 'simplecov'
SimpleCov.start

Given('these Users:') do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  table.hashes.each do |h|
    u = User.new(h)
    u.save
  end
end
Given('I am on the items index page') do
  visit root_path
end
Given('I am on the items index page, not logged in') do
  destroy_user_session_path
  visit root_path
end
Then('I should see {string}') do |string|
  page.has_content? string
end
But('I should not see {string}') do |string|
  !page.has_content?(string)
end
When('I press {string}') do |string|
  page.click_on string
end
When('I login as {string} and {string}') do |string, string2|
  page.fill_in "Email", :with => string
  page.fill_in "Password", :with => string2
  page.click_button "Log in"
end 
Then('I should be on the items index page') do
  #index can be / or /products
  expect(page).to have_current_path(/\/|\/items/)
end
Then('I should be on the create user page') do
  expect(page).to have_current_path('/users/sign_up')
end
When('I fill in the following initializers:') do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  page.fill_in "Name", :with => "allegra"
  page.fill_in "user_payment", :with => "venmo"
  page.fill_in "Email", :with => "aknox@colgate.edu"
  page.fill_in "Password", :with => "password"
  page.fill_in "Password confirmation", :with => "password"
end
When('I fill in the following credentials:') do |table|
  page.fill_in "Email", :with => "a@email.com"
  page.fill_in "Password", :with => "password"
end
Then('I should be on the sign in page') do 
  expect(page).to have_current_path("/users/sign_in")
end 
Then('I should be on the edit profile page') do
 expect(page).to have_current_path("/users/edit")
end
When('I edit my name and re-enter my password') do  |table|
  page.fill_in "Name", :with => "Allegra Knox"
  page.fill_in "user_current_password", :with => "password"
end
Given('I am on the new user page') do
  visit new_user_session_path
end
# Capybara.current_driver = :webkit
Then('I should accept the popup to confirm') do
  accept_alert do
   click_link('OK')
  end
end 






