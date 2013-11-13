source 'https://rubygems.org'

gem 'rails'

gem 'mysql2'

gem 'therubyracer' # to support twitter-bootstrap-rails
gem 'less-rails' #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem 'twitter-bootstrap-rails' #design for admin part
gem 'devise' #authentication
gem 'simple_form' #form builder admin part
gem 'truncate_html' #to truncate text with html tags
gem "ckeditor" #to have html editor for articles
gem "carrierwave" #to save images
gem "mini_magick" #to crop images

gem 'chosen-rails' #used for selects in admin area
gem 'compass-rails', github: 'Compass/compass-rails'
gem 'pry' #for debug
gem 'kaminari' #paginate records
gem 'dalli' #to store cache
gem "ransack", github: "ernie/ransack" #to search articles
gem "coderay"  #to highlight ruby syntax
gem "RedCloth" #to highlight ruby syntax

gem 'exception_notification', '3.0.0' #handle errors on prod

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :development, :test do
  gem 'quiet_assets' #not to log get requests to assets files
  gem 'capistrano' #to setup deploy
  gem 'capistrano-ext' #to setup deploy
  gem 'rvm-capistrano' #to setup deploy
end

group :test do
  gem 'simplecov' #generate code coverage
  gem 'zeus' #speed up test start
  gem 'factory_girl_rails' #generate models for tests
  gem 'rspec-rails' #rspec expectations for tests
  gem 'database_cleaner' #setup database clean strategy
  gem 'faker' #to generate fake data
end

gem 'jquery-rails'
gem 'newrelic_rpm'

