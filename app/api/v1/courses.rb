module V1
  class Courses < Grape::API
    before { authenticate! }

    desc 'Get user courses info'

    params do
      optional :filter_expire, type: Boolean
    end

    get "/account/courses" do
        
      @user_courses = UserCourse.includes(:pay_history, course: [:category]).filter_by_user(@current_user.id)
      @user_courses = @user_courses.filter_by_expired if params[:filter_expire]
      
      present @user_courses, with: V1::Entities::UserCourse
    end
  end
end