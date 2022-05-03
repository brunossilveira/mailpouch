class NewsletterMessagesController < ApplicationController
  def show
    @newsletter_message = NewsletterMessage.find_by!(id: params[:id], user: current_user)
  end

  def body
    @newsletter_message = NewsletterMessage.find_by!(id: params[:id], user: current_user)

    respond_to do |format|
      format.html {  render inline: @newsletter_message.body }
    end
  end
end
