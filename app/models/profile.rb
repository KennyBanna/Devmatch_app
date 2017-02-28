class Profile < ApplicationRecord
  
  belongs_to :user
  
  # Profile avatar
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  
  validates :fname, :lname, presence: true
  validates :description, length: {in: 5..100}
  
end