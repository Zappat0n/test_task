require 'rails_helper'

RSpec.describe JobApplication, type: :model do
  let(:user) { User.create(username: 'John', password: 'abcdefg') }
  let(:job) { Job.create(title: 'Baker') }

  it 'Happy path' do
    expect(JobApplication.count).to eq 0
    JobApplication.create(applicant_id: user.id, job: job, message: 'Make bread')
    expect(JobApplication.count).to eq 1
  end

  it 'Does not allow nil user' do
    ja = JobApplication.new(job: job, message: 'Make bread')
    expect(ja.valid?).to be false
  end

  it 'Does not allow nil job' do
    ja = JobApplication.create(applicant_id: user.id, message: 'Make bread')
    expect(ja.valid?).to be false
  end

  it 'Does not allow nil message' do
    ja = JobApplication.create(applicant_id: user.id, job: job)
    expect(ja.valid?).to be false
  end
end
