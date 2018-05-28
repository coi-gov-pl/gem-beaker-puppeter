require 'beaker-rspec'
require 'beaker/puppeter'

RSpec.configure do |c|
  c.formatter = :documentation
  c.order     = :defined
end
