require_relative 'config/boot'

class Trasina < Sinatra::Base
  set :root, File.dirname(__FILE__)

  configure :development do
    register Sinatra::Reloader
  end

  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: %i(get post put delete options)
    end
  end

  send(:use, "RootController".constantize)
end

require_relative 'config/application'

Trasina.run! if __FILE__ == $PROGRAM_NAME
