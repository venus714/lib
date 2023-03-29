class Author < ApplicationRecord
    has_many :books, dependent: :destroy
  
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :phone, presence: true
  end
  