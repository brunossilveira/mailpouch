require 'github/markup'

class PostsController < ApplicationController
  def index
    @posts = Post.where('published_at <= ?', Time.zone.now).all
  end

  def show
    @post = Post.friendly.find(params[:id])
    @content = GitHub::Markup.render_s(GitHub::Markups::MARKUP_MARKDOWN, @post.content)
  end
end
