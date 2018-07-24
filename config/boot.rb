ENV['RACK_ENV'] ||= 'development'

require "json"
require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym
require 'active_support'

Dotenv.load

Dir["./app/**/*.rb"].each { |file| require file }
