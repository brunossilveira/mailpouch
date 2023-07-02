class BestNewslettersController < ApplicationController
  def index
    @categories = Newsletter.pluck(:category).compact.map(&:downcase).uniq
    @category = params[:category] || 'startups'

    @newsletters = Newsletter.where(category: [@category.downcase, @category.humanize])
  end
end
