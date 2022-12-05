module MetaTagsHelper
  def title
    content_for(:title) || 'Enjoy the newsletters you love in your own time!'
  end

  def description
    content_for(:description) || 'You get an email address to subscribe to newsletters and then you can choose receive them on your own time!'
  end

  def image
    nil
  end
end
