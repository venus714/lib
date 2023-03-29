class Reading < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :read_date, presence: true
end
