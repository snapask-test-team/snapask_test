class AddPayHistoryReferenceToUserCourseModel < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_courses, :pay_history
  end
end
