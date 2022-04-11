class InboxController < ApplicationController
  before_action :authenticate_user!

  def index
    @newsletter_messages = NewsletterMessage.where(user: current_user).order(created_at: :desc)
  end
end
