require 'rails_helper'

RSpec.describe "JobApplications", type: :request do
  let(:user) { User.create(username: 'John', password: 'abcdefg') }
  let(:job) { Job.create(title: 'Baker') }

  describe "POST /job_applications" do
    it 'Happy path' do
      post '/login', params: { username: user.username, password: user.password }
      post '/job_applications', params: { job_application: { applicant_id: user.id, job_id: job.id, message: 'Hello' } }
      
      expect(response).to have_http_status(:success)
      expect(JobApplication.count).to eq 1
    end

    it 'Do not allow two job_applications for the same user and job' do
      post '/login', params: { username: user.username, password: user.password }
      post '/job_applications', params: { job_application: { applicant_id: user.id, job_id: job.id, message: 'Hello' } }
      post '/job_applications', params: { job_application: { applicant_id: user.id, job_id: job.id, message: 'Hello' } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JobApplication.count).to eq 1
    end

  end
end
