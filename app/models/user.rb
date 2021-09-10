class User < ApplicationRecord
  before_save { self.email = self.email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_ADRESS_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_ADRESS_REGEX }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password 
end
