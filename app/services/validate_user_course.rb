class ValidateUserCourse
  include ActiveModel::Validations

  attr_reader :course
  attr_reader :user_courses

  validate :check_launch, :check_expired_record

  def initialize(params = {})
    @course = params.delete(:course)
    @user = params.delete(:user)
    @user_courses = UserCourse.where(user_id: @user.id)
  end

  private

  def check_launch
    if !@course.launch 
      errors.add(:course, :launch, message: "the course is off the shelves") 
    end
  end

  def check_expired_record
    records = @user_courses.select { |record| record.course_id == @course.id && record.expired_time > DateTime.now }
    errors.add(:user_courses, :expire_time, message: "the course is not yet expire") if records.any?
  end

end