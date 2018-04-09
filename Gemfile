source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.0'

gem 'pg'

gem 'puma', '~> 3.7'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'whenever', require: false

gem 'turbolinks', '~> 5'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'
# gem 'sidekiq'

# gem 'capistrano-rails', group: :development

gem 'devise'

gem 'nokogiri'

gem 'rest-client'

group :test do
  gem 'rspec', '>=3.0'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'webmock'
  gem 'timecop'
  gem 'shoulda-matchers', require: false
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
