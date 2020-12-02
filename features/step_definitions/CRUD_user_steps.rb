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
Then('I should see {string}') do |string|
  page.should have_content(string)
end
But('I should not see {string}') do |string|
  page.should_not have_content(string)
end
When('I press {string}') do |string|
  page.click_on string
end
Then('I should be on the items index page') do
  #index can be / or /items
  expect(page).to have_current_path(/\/|\/items/)
end
