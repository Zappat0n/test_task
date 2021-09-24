require 'rails_helper'

RSpec.describe Job, type: :model do
  it 'Happy path' do
    expect(Job.count).to eq 0
    Job.create(title: 'Baker')
    expect(Job.count).to eq 1
  end

  it 'Does not allow empty title' do
    job = Job.create
    expect(job.valid?).to be false
  end
end
