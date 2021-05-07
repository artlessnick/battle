class User < ApplicationRecord
  has_many :gamescores
  has_many :results
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: {minimum: 3},
                   uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255},
            uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> (u) { u.password_digest_changed? }
  has_secure_password

end
