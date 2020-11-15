require 'rails_helper'

RSpec.describe "index page", type: :feature do
  before :each do
   @u1 = User.create!(name: "Mark", email: "mark@colgate.edu", payment: "venmo", password: "abcdef")
   @u2 = User.create!(name: "Amy", email: "amy@colgate.edu", payment: "cash", password: "ghijkl")
   Item.create!(name: "Table", price: 13.13, description: "Surface with 4 legs. It is a table.", listed: true, status: "available", deliverable: true, user_id: @u1.id)
   Item.create!(name: "Muffin Tin", price: 2.00, description: "Tin for making muffins.", listed: true, status: "available", deliverable: true, user_id: @u2.id)
   Item.create!(name: "Microphone", price: 15.99, description: "Great for singing.", listed: true, status: "available", deliverable: true, user_id: @u2.id)

   visit "/items"
  end

  it "should have links from each item name to 'show' pages" do
    expect(page).to have_link("Table")
    expect(page).to have_link("Muffin Tin")
  end

  it "show link for item and should show details for the items" do
    click_link("Table")
    expect(page).to have_link("Back to item list")
    expect(page).to have_content("Table")
    expect(page).to have_content("Surface with 4 legs. It is a table.")
    expect(page).to have_content("13.13")
    expect(page).to have_content("available")
  end
end
