class NewsletterDatabaseController < ApplicationController
  def index
    results = Rails.cache.fetch('newsletter_database', expires_in: 1.day) do
      uri = URI('https://findnewsletters.com/search.json')
      data = Net::HTTP.get(uri)

      JSON.parse(data)
    end

    @categories = results.collect { |r| r['category'] }.uniq

    if params[:category].present?
      results = results.select { |r| r['category'] == params[:category] }
    end

    @newsletters = results
  end
end
