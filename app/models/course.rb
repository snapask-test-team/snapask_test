class Course < ApplicationRecord
  has_many :user_courses
  has_many :courses, through: :user_courses
  belongs_to :category

  validates :price, :currency, :url, :expire_day, presence: true
end
