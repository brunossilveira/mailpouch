source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.3"

gem "administrate"
gem "google-cloud-storage"
gem "lograge"
gem "bootsnap", require: false
gem "devise"
gem "importmap-rails"
gem "jbuilder"
gem "montrose"
gem "pay", "~> 5.0"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.2", ">= 7.0.2.3"
gem "redis", "~> 4.0"
gem "sidekiq", "~> 6.4"
gem "sentry-ruby"
gem "sentry-rails"
gem "sentry-sidekiq"
gem "sprockets-rails"
gem "stimulus-rails"
gem "stripe", "~> 7.0"
gem "tailwindcss-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "sanitize"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "rspec-rails"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "dockerfile-rails", ">= 1.2", :group => :development
