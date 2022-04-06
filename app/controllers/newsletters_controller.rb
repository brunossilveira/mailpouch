class NewslettersController < ApplicationController
  def index
    @newsletters = Newsletter.where(user: current_user)
  end
end
