# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Item.delete_all

u1 = User.create!(name: "Brian Casey", email: "asong@colgate.edu", payment: "venmo at bcasey13", password: "gogate")
u2 = User.create!(name: "Lady Gaga", email: "aknox@colgate.edu", payment: "cash", password: "rarara")
u3 = User.create!(name: "Meg Imperato", email: "mimperato@colgate.edu", payment: "cash", password: "password")

Item.create!(name: "Table", price: 13.13, description: "Surface with 4 legs. It is a table.", listed: true, status: "available", deliverable: true, user: u1, category: "Furniture")
Item.create!(name: "Muffin Tin", price: 2.00, description: "Tin for making muffins.", listed: true, status: "available", deliverable: true, user: u1, category: "Furniture")
Item.create!(name: "Microphone", price: 15.99, description: "Great for singing.", listed: true, status: "available", deliverable: true, user: u2, category: "Electronics")


