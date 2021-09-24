class JobApplication < ApplicationRecord
  belongs_to :applicant, class_name: 'User'
  belongs_to :job

  validates :message, presence: true
end
