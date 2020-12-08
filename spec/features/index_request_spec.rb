require 'rails_helper'

RSpec.describe "index page", type: :feature do
  let(:price_sort) { ["Muffin Tin", "Table", "Microphone"] }
  let(:name_sort) { [ "Microphone", "Muffin Tin", "Table"] }

  before :each do
   @u1 = User.create!(name: "Mark", email: "mark@colgate.edu", payment: "venmo", password: "abcdef")
   @u2 = User.create!(name: "Amy", email: "amy@colgate.edu", payment: "cash", password: "ghijkl")
   Item.create!(name: "Table", price: 13.13, description: "Surface with 4 legs. It is a table.", listed: true, status: "available", deliverable: true, user_id: @u1.id)
   Item.create!(name: "Muffin Tin", price: 2.00, description: "Tin for making muffins.", listed: true, status: "available", deliverable: true, user_id: @u1.id)
   Item.create!(name: "Microphone", price: 15.99, description: "Great for singing.", listed: true, status: "available", deliverable: true, user_id: @u2.id)

   visit "/items"
  end

  it "should show the items in name order by default" do
    names = []
    page.all(".itemname").each { |x| names << x.text }
    expect(names).to match_array(names.sort)
  end

  it "should show the items in correct price order when sorting by price" do
    names = []
    click_link("Price")
    page.all(".itemname").each { |x| names << x.text }
    expect(names).to match_array(price_sort)
  end

  it "should show the items in correct name order when sorting by name" do
    names = []
    click_link("Name")
    page.all(".itemname").each { |x| names << x.text }
    expect(names).to match_array(names.sort)
  end
  
  it "should not show items where listed is false" do
    Item.create!(name: "Backpack", price: 5.00, description: "Holds things.", listed: false, status: "unavailable", deliverable: true, user_id: @u2.id)
    names = []
    page.all(".itemname").each { |x| names << x.text }
    expect(names).not_to include("Backpack")
  end
  
  it "should not allow user to create an item if not logged in" do 
    expect(page).to have_content("Log in with Google SSO")
    expect(page).not_to have_content("List an item")
    visit(new_item_path)
    expect(page).to have_content("You must be logged in to perform this action.")
  end
  
  it "should not allow the user to query an item by search" do 
    fill_in :search, with: "M"
    click_button 'Search'
    expect(page).to have_content("Muffin Tin")
    expect(page).to have_content("Microphone")
    expect(page).to_not have_content("Table")
  end
  
  it "should redirect to root path for empty searches" do 
    fill_in :search, with: ""
    click_button 'Search'
    expect(page).to have_content("Muffin Tin")
    expect(page).to have_content("Microphone")
    expect(page).to have_content("Table")
  end

end

