require 'rails_helper'
require 'capybara/rails'

RSpec.describe ItemsController, type: :controller do
    before :each do
        User.create!(name: "mariam", email: "mariam@colgate.edu", password: "colgate")
    end
    context "root route" do
        it "routes to rental_properties#index" do
            expect(:get => '/').to route_to(:controller => 'items', :action => 'index')
        end
    end

    context "index" do
        it "routes correctly" do
            get :index
            expect(response.status).to eq(200)
        end

        it "renders the index template and does default sorting" do
            x, y = Item.create!(name: 'apple', price: 10, user_id: 1), Item.create!(name: 'zebra', price: 20, user_id: 1)
            get :index
            expect(assigns(:items)).to match_array([x,y])
            expect(response).to render_template("index")
        end
    end

    context "show" do
        it "routes correctly" do
            p = Item.new(name: "Pwll o le", price: 10, user_id: 1)
            expect(Item).to receive(:find).with(eq("1").or eq(1)) { p }
            get :show, :params => { :id => 1 }
            expect(response.status).to eq(200)
        end

        it "renders the show template" do
            p = Item.new(name: "Pwll o le", price: 10, user_id: 1)
            expect(Item).to receive(:find).with(eq("1").or eq(1)) { p }
            get :show, :params => { :id => 1 }
            expect(response).to render_template("show")
            expect(assigns(:item)).to eq(p)
        end
    end
end
