class NewsletterMessagesController < ApplicationController
  def show
    @newsletter_message = NewsletterMessage.find(params[:id])
  end
end
