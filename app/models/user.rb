class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_many :sales
  belongs_to :role
  validates :username, presence: true, uniqueness: true
  validates :email_address, presence: true, uniqueness: true
  validates_format_of :email_address, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: I18n.t("users.email.format")
  validates :phone, presence: false,
                    numericality: { only_integer: true, message: I18n.t("users.phone.digits") },
                    length: { maximum: 10, message: I18n.t("users.phone.size") }
  validates :role, presence: true
end
