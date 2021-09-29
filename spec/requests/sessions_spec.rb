require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:user) { User.create(username: 'John', password: 'abcdefg') }

  describe "POST /login" do
    it "Happy path" do
      post '/login', params: { username: user.username, password: user.password }
      expect(response).to redirect_to('/jobs')

      get "/jobs"
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE /logout" do
    it "Happy path" do
      post '/login', params: { username: user.username, password: user.password }

      delete '/logout'
      expect(response).to redirect_to('/')
    end
  end
end
