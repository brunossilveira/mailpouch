class InboxController < ApplicationController
  before_action :authenticate_user!

  def index
    @newsletter_messages = NewsletterMessage.where(user: current_user).unread.order(created_at: :desc)
    @any_newsletters = NewsletterMessage.where(user: current_user).any?
    @preference = current_user.preference
  end
end
