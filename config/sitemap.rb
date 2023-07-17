SitemapGenerator::Sitemap.default_host = "https://mailpouch.app"
SitemapGenerator::Sitemap.create_index = true
SitemapGenerator::Sitemap.create do
  add '/best-newsletters', changefreq: 'never'
  add '/posts', changefreq: 'weekly'
  add '/privacy_policy', changefreq: 'never'

  Post.where('published_at <= ?', Time.zone.now).find_each do |post|
    add post_path(post), lastmod: post.updated_at
  end
end
