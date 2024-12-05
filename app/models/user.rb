class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_many :sales
  belongs_to :role
  validates :username, presence: true, uniqueness: true
  validates :email_address, presence: true, uniqueness: true
  validates_format_of :email_address, with: URI::MailTo::EMAIL_REGEXP
end
