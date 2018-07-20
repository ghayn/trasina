require './app'
require 'rspec'

RSpec.configure do |config|
  include Rack::Test::Methods

  def app
    Trasina
  end
end
