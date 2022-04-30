class ApplicationController < ActionController::Base
  
  def authenticate_manager
    unless current_manager
      flash[:alert] = "Not allow!"
      redirect_to root_path
    end
  end
end
