class NewslettersController < ApplicationController
  before_action :authenticate_user!

  def index
    @newsletters = Newsletter.where(user: current_user)
  end
end
