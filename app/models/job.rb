class Job < ApplicationRecord
  validates :title, presence: true

  def self.ratings(applications, users)
    applications.each { |application| users.push(application.applicant) unless users.include?(application.applicant) }

    Rating.where(user_id: users).group(:user_id).select(
      'AVG(rating_value) AS avg',
      'COUNT(rating_value) AS count',
      'user_id'
    )
  end
end
