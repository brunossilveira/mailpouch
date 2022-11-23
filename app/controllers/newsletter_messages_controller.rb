class NewsletterMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_if_not_subscribed

  def parsed
    @newsletter_message = NewsletterMessage.find_by!(id: params[:id], user: current_user)
  end

  def show
    @newsletter_message = NewsletterMessage.find_by!(id: params[:id], user: current_user)
    @newsletter_message.update(read: true)
  end

  def read
    @newsletter_message = NewsletterMessage.find_by!(id: params[:id], user: current_user)
    @newsletter_message.update(read: true)

    redirect_to inbox_index_path
  end

  private

  def redirect_if_not_subscribed
    if current_user && !current_user.subscribed?
      redirect_to root_path
    end
  end
end
