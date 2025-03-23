class User < ApplicationRecord
  has_many :user_ciphers
  has_many :ciphers, through: :user_ciphers

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end