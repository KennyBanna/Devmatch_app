class Profile < ApplicationRecord
  
  belongs_to :user
  
  validates :fname, :lname, presence: true
  validates :description, length: {in: 5..100}
  
end