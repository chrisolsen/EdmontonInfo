require "rubygems"
require "vendor/sinatra/lib/sinatra"
require "lib/init"
require "edmonton"

set :environment, :production
disable :run, :reload

run Sinatra::Application
