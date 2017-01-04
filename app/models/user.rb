class User < ApplicationRecord
  has_many :tokens

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

  before_save { self.email = email.downcase }

  validates :name, presence: true
  validates :email, presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: EMAIL_REGEX, multiline: true }

end
