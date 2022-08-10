class Inbox::ReadController < ApplicationController
  before_action :authenticate_user!

  def index
    @newsletter_messages = NewsletterMessage.where(user:  current_user).read
  end
end
