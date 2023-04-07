class NewsletterDatabaseController < ApplicationController
  def index
    @categories = Newsletter.pluck(:category).map(&:downcase).uniq.compact
    @category = params[:category] || 'startups'

    @newsletters = Newsletter.where(category: [@category.downcase, @category.humanize])
  end
end
