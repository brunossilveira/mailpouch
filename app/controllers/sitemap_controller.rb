class SitemapController < ApplicationController
  def index
    @host = "https://mailpouch.app"
    @posts = Post.published
  end
end
