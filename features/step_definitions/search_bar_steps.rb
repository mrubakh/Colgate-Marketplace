require 'simplecov'
SimpleCov.start


Given('these Items:') do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  table.hashes.each do |h|
    h[:user_id] = 1
    i = Item.new(h)
    i.save
  end
end

When('I search {string}') do |string|
  #pending # Write code here that turns the phrase above into concrete actions
  
  find("#searchBar").set(string)
  click_button "searchSubmit"
  #find('#searchBar').send_keys('keyword', :enter)
end
