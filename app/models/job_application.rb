class JobApplication < ApplicationRecord
  belongs_to :applicant, class_name: 'User'
  belongs_to :job

  validates :message, presence: true
  validates :job, uniqueness: { scope: :applicant_id }

  scope :for_job_with_username, ->(job_id) { joins(:applicant).select(:id, :applicant_id, :message, :username).where('job_id = ?', job_id).references(:users) }
end
