source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "~> 7.0.8", ">= 7.0.8.1"
gem "puma", "~> 5.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "mongoid", "~> 8.1"
gem "enumerize", "~> 2.8"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'guard'
  gem 'guard-rspec'
end

group :development do
  gem "byebug"
end

group :test do
  gem "rspec", "~> 3.13"
  gem "rspec-rails", "~> 6.1"
end

