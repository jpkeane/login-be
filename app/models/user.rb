class User < ApplicationRecord
  belongs_to :role

  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9\_\-\.]+\z/

  validates :name,      presence: true
  validates :username,  presence: true, format: { with: VALID_USERNAME_REGEX }, uniqueness: { case_sensitive: false }
  validates :password,  presence: true

  has_secure_password
end
