class User < ApplicationRecord
    has_secure_password
    has_many :readings, dependent: :destroy
    has_many :books, through: :readings
  
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, length: { minimum: 6 }
    validates :role, presence: true
  end
  