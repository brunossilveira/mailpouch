class NewsletterMessagesController < ApplicationController
  def show
    @newsletter_message = NewsletterMessage.first
  end
end
