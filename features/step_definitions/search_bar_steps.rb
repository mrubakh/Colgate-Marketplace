require 'simplecov'

 Given('these Items:') do |table|
   # table is a Cucumber::MultilineArgument::DataTable
   table.hashes.each do |h|
     h[:user_id] = 1
     h[:listed] = true
     i = Item.new(h)
     i.save
   end
 end

 When('I search {string}') do |string|
   #pending # Write code here that turns the phrase above into concrete actions

   find("#searchBar").set(string)
   #fill_in "searchBar", :with => (string + '\n')
   click_button "searchButton"
   #find('#searchBar').send_keys('keyword', :enter)
 end