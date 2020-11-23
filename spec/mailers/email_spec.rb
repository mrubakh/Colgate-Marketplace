require "rails_helper"

RSpec.describe EmailMailer, type: :mailer do
  it "sends email" do
    seller = User.create!(name: "Lady Gaga", email: "aknox@colgate.edu", payment: "cash", password: "rarara")
    buyer = User.create!(name: "Meg Imperato", email: "mimperato@colgate.edu", payment: "cash", password: "password")
    item = Item.create!(name: "Microphone", price: 15.99, description: "Great for singing.", listed: true, status: "available", deliverable: true, user: seller)
    email = EmailMailer.with(seller).interest_email(seller, buyer, item)


    assert_emails 1 do
      email.deliver_now
    end
    
    assert_equal email.to, [seller.email]
    assert_equal email.from, ['colgatemarketplace@gmail.com']
    assert_equal email.subject, "#{buyer.name} is interested in your #{item.name}"
  end
end
