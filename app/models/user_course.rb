class UserCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course
  belongs_to :pay_history

  scope :filter_by_user, -> (user_id) { where user_id: user_id }
  scope :filter_by_expired, -> { where("expired_time >= ?", Time.zone.now) }

end
