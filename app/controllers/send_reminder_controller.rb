class SendReminderController < ApplicationController
  before_action :authenticate_user!

  def index
    head :unauthorized unless current_user.admin?

    user = User.find(:user_id)

    ReminderMailer.with(user: user).deliver_later

    render nothing: true
  end
end
