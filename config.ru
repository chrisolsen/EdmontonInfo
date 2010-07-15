require "rubygems"
require "vendor/sinatra/lib/sinatra"

require "dm-core"
require "dm-timestamps"
require "dm-migrations"
require "dm-sqlite-adapter"
require "dm-serializer"
require "dm-types"
require "json"

require "edmonton_info"

#set :environment, :production

run Sinatra::Application
