require 'rails_helper'

  RSpec.describe "StaticPages", type: :request do

    describe "GET /about" do
      it "returns http success" do
        get "/static_pages/about"
        expect(response).to have_http_status(:success)
      end
    end

  end 