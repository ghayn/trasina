ENV['RACK_ENV'] ||= 'development'

require "json"
require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

Dir["./app/**/*.rb"].each { |file| require file }

if development?
  require "sinatra/reloader" if development?
end
