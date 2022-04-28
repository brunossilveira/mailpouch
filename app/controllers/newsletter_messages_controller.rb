class NewsletterMessagesController < ApplicationController
  def show
    @newsletter_message = NewsletterMessage.find(params[:id])
  end

  def body
    @newsletter_message = NewsletterMessage.find(params[:id])

    respond_to do |format|
      format.html {  render inline: @newsletter_message.body }
    end
  end
end
