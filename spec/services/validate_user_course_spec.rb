require 'rails_helper'

RSpec.describe ValidateUserCourse do
  describe "check validate_user_course service object" do
    before do 
      @category = Category.create(name: "Math")
      @course = Course.create(subject: "test course", 
                          price: 100.01,
                          currency: "TWD",
                          url: "http://localhost:3000",
                          description: "Math test course",
                          launch: true, 
                          expire_day: 10,
                          category_id: @category.id
                         )
    
      @user = User.create(email: "test@gmail.com", password: "123456")
    end

    it 'validate success' do
      service = ValidateUserCourse.new(course: @course, user: @user)
      service.valid?

      expect(service.errors.any?).to eq (false)
    end

    it 'validate unsuccess' do
      payment = Payment.new(user: @user, course: @course, pay_information: { type: 1})
      @result = payment.perform
      if @result
        @user.user_courses.create(course_id: @course.id, pay_history_id: @result.id, expired_time: @result.pay_time + (@course.expire_day).days)
      end
    

      service = ValidateUserCourse.new(course: @course, user: @user)
      service.valid?

      expect(service.errors.any?).to eq (true)
    end

  end
end
