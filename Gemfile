source "https://rubygems.org"

gem "rails", "~> 8.1.1"
gem "propshaft"
gem "sqlite3"
gem "puma"

gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

gem "mission_control-jobs"
gem "administrate"
gem "ferrum"

gem "tailwindcss-rails"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "bundler-audit", require: false
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "awesome_print"
end

group :development do
  gem "web-console"
  gem "hotwire-spark"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
