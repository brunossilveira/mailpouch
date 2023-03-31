class SendReminderController < ApplicationController
  before_action :authenticate_user!

  def index
    head :unauthorized unless current_user.admin?

    user = User.find(params[:user_id])

    ReminderMailer.with(user: user).reminder_email.deliver_now

    render nothing: true
  end
end
