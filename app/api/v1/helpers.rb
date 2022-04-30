module V1
  module Helpers

    def authenticate!
      error!('401 Unauthorized', 401) unless current_user
    end

    def current_user
      header = request.headers['Authorization']
      header = header.split(' ').last if header

      begin
        user_id = JsonWebToken.decode(header)[:sub]
      rescue 
        nil
      end

      @current_user ||= User.find_by_id(user_id)
    end

  end
end