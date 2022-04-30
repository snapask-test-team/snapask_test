class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :user_courses
  has_many :courses, through: :user_courses

  def gererate_token
    payload = { iss: Rails.application.class.parent_name, sub: self.id }
    JsonWebToken.encode(payload)
  end
  
end
