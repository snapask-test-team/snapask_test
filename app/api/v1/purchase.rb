module V1
  class Purchase < Grape::API
    before { authenticate! }

    desc 'Purchase course'

    params do
      optional :pay_information, type: Hash do
        requires :type, type: Integer, allow_blank: false
      end
    end

    post "/purchase/:course_id" do
      course = Course.find(params[:course_id])

      service = ValidateUserCourse.new(course: course, user: @current_user)
      error!({ error: { message: service.errors.full_messages.join(",")} }, 400) unless service.valid?

      payment = Payment.new(course: course, user: @current_user, pay_information: params[:pay_information])

      result = payment.perform
      error!({ error: { message: "Purchase is failed"} }, 400) unless result
      
      @current_user.user_courses.create(course_id: course.id, pay_history_id: result.id, expired_time: result.pay_time + (course.expire_day).days)
      { message: "success"  }
    end
  end
end