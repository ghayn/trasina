require "json"
require 'bundler'
Bundler.require :default
Dotenv.load ".env.#{ENV['RACK_ENV']}"
Bundler.require ENV['RACK_ENV'].to_sym

Dir["./app/**/*.rb"].each { |file| require file }
