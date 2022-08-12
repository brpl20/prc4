# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.4'

gem 'autoprefixer-rails'
gem 'aws-sdk-s3', require: false
gem 'bootsnap', require: false
gem 'cancancan'
gem 'cocoon'
gem 'coffee-rails', '~> 5.0'
gem 'devise'
gem 'devise-bootstrap-views', '~> 1.0'
gem 'docx', require: ['docx']
gem 'dotenv-rails', groups: %w[development test]
gem 'extensobr'
gem 'faker', git: 'https://github.com/faker-ruby/faker.git', branch: 'master'
gem 'font-awesome-rails'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'omniauth-google-oauth2'
gem 'pdf-forms'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3'
gem 'rack', '>= 2.2.3'
gem 'rails', '>= 6.0.3.5'
gem 'rails_admin', '~> 2.0'
gem 'rails-i18n', '~> 6.0.0'
gem 's3'
gem 'sass-rails', '~> 5.0'
gem 'similar_text', '~> 0.0.4'
gem 'simple_form'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', '~> 5.x'

group :development, :test do
  gem 'better_errors'
  gem 'byebug', platforms: %w[mri mingw x64_mingw]
  gem 'pry-rails'
end

group :development do
  gem 'annotate'
  gem 'binding_of_caller'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'chromedriver-helper'
  gem 'selenium-webdriver'
end

gem 'tzinfo-data', platforms: %w[mingw mswin x64_mingw jruby]
