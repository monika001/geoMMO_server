source 'https://rubygems.org'
ruby '2.1.2'

gem 'rails'
gem 'pg'

gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'haml-rails'
gem 'sass-rails', '>= 4.0.3'
gem 'compass-rails'
gem 'bootstrap-sass'
gem 'font-awesome-rails'

gem 'activeadmin', github: 'activeadmin'
gem 'devise'

gem 'uglifier', '>= 1.3.0'
gem 'active_model_serializers'

gem 'bcrypt'

group :development do
  gem 'spring'
  gem 'figaro'
end

group :development, :test do
  gem 'pry'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'nyan-cat-formatter'
  gem 'faker'
  gem 'terminal-notifier-guard'
  gem "codeclimate-test-reporter", require: nil
end

group :production do
  gem 'rails_12factor'
  gem 'puma'
  gem 'rollbar'
end
