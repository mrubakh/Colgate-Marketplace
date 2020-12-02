require 'simplecov'
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    it "creates a new user correctly" do
        x = User.create(name: 'allegra', email: 'aknox@colgate.edu', password: "password", payment: "allegra-knox")
        expect(x.name).to eq 'allegra'
        expect(x.email).to eq 'aknox@colgate.edu'
        expect(x.password).to eq 'password'
        expect(x.payment).to eq 'allegra-knox'
    end
  it 'should return true if new and save correctly' do
    u = User.new :name=>"alle", :payment=>"venmo", :email=>"aknox@email.com", :password=>"password"
    u.save
    expect(User.new :name=>"alle", :payment=>"venmo", :email=>"aknox@email.com", :id=>1, :password=>"password").to eq u
  end
  
  it 'should display user page' do
      u = User.create(name: 'noahj', email: 'n@colgate.edu', password: "password", payment: "venmo" )
      i = Item.new(name: "toy", price: 25.55, description: "Good toy", user_id:1)
      u.items << i
      get :show, params: {:id=> i.id, :email=> u.email, :payment=> u.payment, :userID=>1}
      response.code.should eql("200")
  end
end
