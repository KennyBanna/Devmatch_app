class Contact < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :comment, length: { in: 5..300 }
end