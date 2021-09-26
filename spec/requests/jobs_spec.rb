require 'rails_helper'

RSpec.describe "Jobs", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/jobs/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/jobs/show"
      expect(response).to have_http_status(:success)
    end
  end

end
