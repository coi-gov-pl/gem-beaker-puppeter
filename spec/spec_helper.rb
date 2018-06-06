require 'simplecov'
require 'coveralls'

SimpleCov.start do
  add_filter "/spec/"
end
Coveralls.wear!

require 'beaker/puppeter'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
