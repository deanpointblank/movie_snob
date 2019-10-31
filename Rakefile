ENV["SINATRA_ENV"] ||= "development"

require_relative 'lib/api/api.rb'
require_relative './config/environment'
require 'sinatra/activerecord/rake'

task :console do
    Pry.start
end

