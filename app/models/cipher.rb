class Cipher < ApplicationRecord
  has_many :user_ciphers
  has_many :users, through: :user_ciphers
end