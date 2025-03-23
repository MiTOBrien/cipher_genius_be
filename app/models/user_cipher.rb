class UserCipher < ApplicationRecord
  belongs_to :user
  belongs_to :cipher

  validates :user_id, presence: true
  validates :cipher_id, presence: true
end