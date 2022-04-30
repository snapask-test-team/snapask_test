module V1
  module Entities
    class UserCourse < Entities::Base
      
      expose :expired_time, format_with: :iso8601
      expose :course, using: Entities::Course
      expose :pay_history, using: Entities::PayHistory, as: :pay_information

    end
  end
end