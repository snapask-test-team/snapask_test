module V1
  class Users < Grape::API
    desc 'user login'
    format :json

    params do
      requires :email, type: String, allow_blank: false, regexp: Devise.email_regexp
      requires :password, type: String, allow_blank: false
    end

    post "/login" do
      user = User.find_by_email!(params[:email])

      return error!({ error: { message: "Email or Password is falied"} }, 400) unless user.valid_password?(params[:password])

      { token: user.gererate_token }
    end
  end
end