source "https://rubygems.org"

# Specify your gem's dependencies in beaker-puppeter.gemspec
gemspec

gem 'rake', require: false
gem 'rspec', require: false

group :acceptancetests do
  gem 'beaker-rspec', '>= 6.2.3', require: false
  gem 'beaker-vagrant', require: false
  gem 'vagrant-wrapper', require: false
end

group :tests do
  gem 'coveralls', '>= 0.7.1', require: false
  gem 'simplecov', '>= 0.16.1', require: false
end

group :development do
  gem 'pry', require: false
  gem 'pry-byebug', require: false
end
