class SitemapController < ApplicationController
  def index
    @host = "https://mailpouch.app"
    @posts = Post.published
    @categories = Newsletter.pluck(:category).compact.map(&:downcase).uniq
  end
end
