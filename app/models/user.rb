class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, 
          :registerable,
          :recoverable,
          :rememberable,
          :validatable,
          :jwt_authenticatable,
          jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null
  
  has_many :user_ciphers
  has_many :ciphers, through: :user_ciphers

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end