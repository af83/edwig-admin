source 'https://rubygems.org'

git_source(:github) { |name| "https://github.com/#{name}.git" }
git_source(:af83) { |name| "git@github.com:af83/#{name}.git" }


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.3'
# Use sqlite3 as the database for Active Record
gem 'postgresql', '~> 1.0'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.3.7'
gem 'font-awesome-sass', '~> 4.7'
gem 'rails-jquery-tags-input'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

gem 'select2-rails'

gem 'devise', '~> 4.3'
gem 'devise_invitable', '~> 1.7', '>= 1.7.2'

gem 'rest-client', '~> 2.0', '>= 2.0.2'

gem 'slim', '~> 3.0', '>= 3.0.8'

gem 'cocoon'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# TODO to be moved to edwig-ruby
gem 'active_attr'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl', '~> 4.7'
  gem 'faker', '~> 1.6', '>= 1.6.6'
  gem 'capybara'
  gem 'fakeweb'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Use Capistrano for deployment
  gem 'capistrano-af83', af83: 'capistrano-af83'

  gem 'bundler-audit'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


# Rails Assets
source 'https://rails-assets.org' do
  gem 'rails-assets-footable', '~> 2.0.3'
  gem 'rails-assets-bootstrap-sass-official', '~> 3.3.0'
end
