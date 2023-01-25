class Inbox::ReadController < ApplicationController
  before_action :authenticate_user!

  def index
    @newsletter_messages = NewsletterMessage.where(user:  current_user).read.order(created_at: :desc)
  end

  def create
    NewsletterMessage.where(user: current_user).unread.update_all(read: true)

    redirect_to inbox_index_path
  end
end
