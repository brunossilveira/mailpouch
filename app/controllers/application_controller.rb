class ApplicationController < ActionController::Base
  before_action :redirect_if_no_username

  def redirect_if_no_username
    if current_user && current_user.username.nil? && controller_name != "profile"
      redirect_to profile_path
    end
  end
end
