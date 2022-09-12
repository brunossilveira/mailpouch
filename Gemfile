source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.0"

gem "aws-sdk-s3", require: false
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
gem "sentry-ruby"
gem "sentry-rails"
gem "sentry-sidekiq"
gem "sidekiq", "~> 6.4"
gem "sprockets-rails"
gem "stimulus-rails"
gem "stripe", "~> 7.0"
gem "tailwindcss-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

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
