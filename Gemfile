source "https://rubygems.org"

ruby "~> 3.3"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.2"
gem "propshaft"
gem "pg"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tailwindcss-ruby", "~> 4.1"
gem "tailwindcss-rails", "~> 4.2"

gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

gem "clearance"
gem "view_component"

gem "pundit", "~> 2.5"
gem "will_paginate", "~> 4.0"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", ">= 1.2"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "rspec-rails", "~> 6.0"
end

group :development do
  gem "web-console"
  gem "bullet"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "factory_bot_rails"
  gem "faker"
  gem "database_cleaner-active_record"
  gem "shoulda-matchers", "~> 5.0"
  gem "rails-controller-testing"
end
