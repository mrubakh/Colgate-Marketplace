require 'simplecov'
SimpleCov.start
require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  it 'should display user page' do
      u = User.create(name: 'noahj', email: 'n@colgate.edu', password: "password", payment: "venmo" )
      i = u.items.create(name: "toy", price: 25.55, description: "Good toy")
      #u = i.user.create(name: 'allegra', email: 'aknox@colgate.edu', password: "password", payment: "allegra-knox" )
      get :show, params: {:id=> u.id, :email=> u.email, :payment=> u.payment}
      response.code.should eq("200")
  end

#These methods are implemented by devise (create and new). We have some more extensive cucumber unit tests 
#for testing creating, editing, deleting, and logging in/out behavior in "features" folder.
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
 end