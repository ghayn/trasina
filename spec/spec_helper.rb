require './app'
require 'rspec'

if test?
  require 'simplecov'
  require 'codecov'
  SimpleCov.start
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

RSpec.configure do |config|
  include Rack::Test::Methods

  def app
    Trasina
  end
end
