require 'users_controller'
describe UsersController do
    it "creates a new user correctly" do
        x = User.create(name: 'allegra', email: 'aknox@colgate.edu', password: "password", payment: "allegra-knox")
        expect(x.name).to eq 'allegra'
        expect(x.email).to eq 'aknox@colgate.edu'
        expect(x.password).to eq 'password'
        expect(x.payment).to eq 'allegra-knox'
    end
end