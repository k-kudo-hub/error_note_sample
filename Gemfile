# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'carrierwave'
gem 'fog-aws'
gem 'devise'
gem 'devise-i18n'
gem 'dotenv-rails'
gem 'jbuilder', '~> 2.7'
gem 'kaminari'
gem 'listen', '~> 3.3'
gem 'mysql2', '~> 0.5'
gem 'puma', '~> 5.3'
gem 'rails', '6.1.3.2'
gem 'rails-i18n'
gem 'rmagick'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'unicorn'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capistrano'
  gem 'capistrano3-unicorn'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
end

group :development do
  gem 'letter_opener_web'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
