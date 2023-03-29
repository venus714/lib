class Publisher < ApplicationRecord
    has_many :books, dependent: :destroy
  
    validates :name, presence: true
    validates :address, presence: true
    validates :phone, presence: true
  end
  