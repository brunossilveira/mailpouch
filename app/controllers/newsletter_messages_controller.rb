class NewsletterMessagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @newsletter_message = NewsletterMessage.find_by!(id: params[:id], user: current_user)
    @newsletter_message.update(read: true)
  end

  def read
    @newsletter_message = NewsletterMessage.find_by!(id: params[:id], user: current_user)
    @newsletter_message.update(read: true)

    redirect_to inbox_index_path
  end
end
