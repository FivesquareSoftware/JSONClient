require 'rubygems'
require 'sinatra'
require 'dependencies'
require 'requires'
require 'configuration'

use Rack::JSONInput
use Rack::JSONOutput

Log.info("Started service with #{Sinatra::Application.environment} environment")

load 'routes/get.rb'
load 'routes/post.rb'
load 'routes/put.rb'
load 'routes/delete.rb'
load 'routes/head.rb'
load 'routes/auth.rb'
