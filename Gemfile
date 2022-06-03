# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "bootsnap", "~> 1.12", require: false
gem "devise", "~> 4.8", ">= 4.8.1"
gem "dotenv-rails", "~> 2.7", ">= 2.7.6"
gem "haml", "~> 5.2", ">= 5.2.2"
gem "importmap-rails", "~> 1.1"
gem "jbuilder", "~> 2.11", ">= 2.11.5"
gem "pg", "~> 1.3", ">= 1.3.5"
gem "puma", "~> 5.6", ">= 5.6.4"
gem "rails", "~> 7.0.3"
gem "sassc-rails", "~> 2.1", ">= 2.1.2"
gem "sprockets-rails", "~> 3.4", ">= 3.4.2"
gem "stimulus-rails", "~> 1.0", ">= 1.0.4"
gem "strip_attributes", "~> 1.13"
gem "turbo-rails", "~> 1.1", ">= 1.1.1"

group :development, :test do
  gem "faker", "~> 2.21"
  gem "pry-rails", "~> 0.3.9"
  gem "rspec-rails", "~> 5.1", ">= 5.1.2"
end

group :development do
  gem "bullet", "~> 7.0", ">= 7.0.2"
  gem "letter_opener_web", "~> 2.0"
  gem "overcommit", "~> 0.59.1"
  gem "pgreset", "~> 0.3"
  gem "rack-mini-profiler", "~> 3.0"
  gem "rubocop", "~> 1.30"
  gem "rubocop-rails", "~> 2.14", ">= 2.14.2"
  gem "spring", "~> 4.0"
  gem "web-console", "~> 4.2"
end

group :test do
  gem "database_cleaner", "~> 2.0", ">= 2.0.1"
  gem "factory_bot_rails", "~> 6.2"
  gem "rails-controller-testing", "~> 1.0", ">= 1.0.5"
  gem "shoulda-callback-matchers", "~> 1.1", ">= 1.1.4"
  gem "shoulda-matchers", "~> 5.1"
  gem "simplecov", "~> 0.21.2"
end
