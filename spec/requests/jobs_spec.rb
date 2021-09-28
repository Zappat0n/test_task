require 'rails_helper'

RSpec.describe "Jobs", type: :request do
  let(:user) { User.create(username: 'John', password: 'abcdefg') }

  describe "GET /jobs" do
    it "Happy path" do
      post '/login', params: { username: user.username, password: user.password }
      expect(response).to redirect_to('/jobs')

      get "/jobs"
      expect(response).to have_http_status(:success)
    end

    it "Redirected if not logged in" do
      get "/jobs"
      expect(response).to redirect_to('/login')
    end
  end

  describe "GET /jobs/:id" do
    it "Happy path" do
      post '/login', params: { username: user.username, password: user.password }
      
      job = Job.create(title: 'Paint house')
      get "/jobs/#{job.id}", params: { id: job.id }
      expect(response).to have_http_status(:success)
    end

    it "Redirected if job not found" do
      post '/login', params: { username: user.username, password: user.password }
      
      get "/jobs/1", params: { id: 1 }
      expect(response).to redirect_to('/jobs')
    end
  end
end
