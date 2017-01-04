class User < ApplicationRecord
  has_many :tokens

  after_initialize :set_defaults, unless: :persisted?
  # The set_defaults will only work if the object is new

  def set_defaults
    self.receive_marketing = false if self.receive_marketing.nil?
    self.receive_articles = false if self.receive_articles.nil?
    self.receive_digest = false if self.receive_digest.nil?
  end

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

  before_save { self.email = email.downcase }

  validates :name, presence: true
  validates :email, presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: EMAIL_REGEX, multiline: true }

end
