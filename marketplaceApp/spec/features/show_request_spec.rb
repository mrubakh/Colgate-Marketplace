require 'rails_helper'

RSpec.describe "index page", type: :feature do
  before :each do
   Item.create!(name: "Table", price: 13.13, image: "pic.jpg", description: "Surface with 4 legs. It is a table.", listed: true, status: "available", deliverable: true, user_id:1)
   Item.create!(name: "Muffin Tin", price: 2.00, image: "muffin.jpg", description: "Tin for making muffins.", listed: true, status: "available", deliverable: true, user_id:1)
   Item.create!(name: "Microphone", price: 15.99, image: "mic.jpg", description: "Great for singing.", listed: true, status: "available", deliverable: true, user_id:2)

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
