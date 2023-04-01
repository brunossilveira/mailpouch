class NewsletterDatabaseController < ApplicationController
  def index
    @categories = Newsletter.pluck(:category).uniq.compact
    @category = params[:category]

    @newsletters = Newsletter.all
    @newsletters = @newsletters.where(category: @category) if @category
  end
end
