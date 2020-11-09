require 'rails_helper'

RSpec.describe "index page", type: :feature do
  let(:price_sort) { ["Muffin Tin", "Table", "Microphone"] }
  let(:name_sort) { [ "Microphone", "Muffin Tin", "Table"] }

  before :each do
   User.create!(name: "Mark", email: "mark@colgate.edu", payment: "venmo", password: "abcdef")
   User.create!(name: "Amy", email: "amy@colgate.edu", payment: "cash", password: "ghijkl")
   Item.create!(name: "Table", price: 13.13, image: "pic.jpg", description: "Surface with 4 legs. It is a table.", listed: true, status: "available", deliverable: true, user_id:1)
   Item.create!(name: "Muffin Tin", price: 2.00, image: "muffin.jpg", description: "Tin for making muffins.", listed: true, status: "available", deliverable: true, user_id:1)
   Item.create!(name: "Microphone", price: 15.99, image: "mic.jpg", description: "Great for singing.", listed: true, status: "available", deliverable: true, user_id:2)

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
end
