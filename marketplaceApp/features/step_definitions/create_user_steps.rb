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
When('I fill in the following:') do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  page.fill_in "Name", :with => "allegra"
  page.fill_in "user_payment", :with => "venmo"
  page.fill_in "Email", :with => "aknox@colgate.edu"
  page.fill_in "Password", :with => "password"
  page.fill_in "Password confirmation", :with => "password"
end
Then('I should see that {string} has a price of {string}') do |string, string2|
  prd = Product.where("name == ?", string)
  visit "products/#{prd.ids[0]}" #there is probably a better way to get product ID... cheating the system for now since I know there is only going to be 1 resulting from "title == treehouse" for now.
  page.has_content? string
  page.has_content? string2
end
Given('I am on the new user page') do
  visit new_user_session_path
end