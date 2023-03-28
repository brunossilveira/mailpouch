class NewsletterSubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @newsletters = NewsletterSubscription.where(user: current_user)
  end
end
