class User < ApplicationRecord
  has_secure_password
  has_one :rating

  validates :username, presence: true
end
