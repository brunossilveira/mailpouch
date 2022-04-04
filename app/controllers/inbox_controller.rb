class InboxController < ApplicationController
  def index
    user = User.last
    @newsletter_messages = NewsletterMessage.where(user: user).order(created_at: :desc)
  end
end
