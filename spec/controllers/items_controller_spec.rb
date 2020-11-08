require 'rails_helper'
require 'capybara/rails'

RSpec.describe ItemsController, type: :controller do
    context "root route" do
        it "routes to items#index" do
            expect(:get => '/').to route_to(:controller => 'items', :action => 'index')
        end
    end

    context "index" do
        it "routes correctly" do
            get :index
            expect(response.status).to eq(200)
        end

        it "renders the index template and does default sorting" do
            x, y = Item.create(name: 'mask', price: 10.00, user_id: 1), Item.create(name: 'phone', price: 109.90, user_id: 1)
            get :index
            # expect(page).to have content x
            # expect(page).to_have content y
            expect(response).to render_template("index")
        end
        
        it "should only show products that have been searched" do
            ## need to set up capybara for this
            
            
            #u = User.create(name: 'noahj', email: 'n@colgate.edu', password: "password", payment: "venmo" )
            #i = u.items.create(name: "toy", price: 25.55, description: "Good toy")
            #x, y = Item.create(name: 'mask', price: 10.00, user_id: 1), Item.create(name: 'phone', price: 109.90, user_id: 1)
            #x, y = Item.create(name: 'toy', price: 10.00, user_id: 1), Item.create(name: 'books', price: 109.90, user_id: 1)
            #names = []
            #get :search, params: {:search => "mask"}
            #page.all(".productname").each { |x| names << x.text }
            #expect(names).to match_array(["mask"])
         end
    end

    context "show" do
        it "routes correctly" do
            p = Item.new(name: "shoes", user_id: 1)
            u = User.new(name: "Mark")
            expect(Item).to receive(:find).with(eq("1").or eq(1)) { p }
            expect(User).to receive(:find).with(eq("1").or eq(1)) { u }
            get :show, :params => { :id => 1 }
            
            expect(response.status).to eq(200)
        end

        it "renders the show template" do
             p = Item.new(name: "shoes", user_id: 1)
            u = User.new(name: "Mark")
            expect(Item).to receive(:find).with(eq("1").or eq(1)) { p }
            expect(User).to receive(:find).with(eq("1").or eq(1)) { u }
            get :show, :params => { :id => 1 }
            
            expect(response).to render_template("show")
            # expect(page).to have_content "shoes"
        end
    end
end
