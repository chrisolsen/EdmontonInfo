require "dm-core"
require "dm-timestamps"
require "dm-migrations"
require "dm-sqlite-adapter"
require "dm-serializer"
require "dm-types"
require "json"

#require "vendor/dm-core-1.0.0/lib/dm-core"
#require "vendor/dm-timestamps-1.0.0/lib/dm-timestamps"
#require "vendor/dm-migrations-1.0.0/lib/dm-migrations"
#require "vendor/dm-sqlite-adapter-1.0.0/lib/dm-sqlite-adapter"
#require "vendor/dm-serializer-1.0.0/lib/dm-serializer"
#require "vendor/dm-types-1.0.0/lib/dm-types/enum"
#require "vendor/json-1.4.3/lib/json"

%w{field 
    city_event 
    rec_facility 
    police_station 
    fire_station 
    park 
    community_league_center 
    school 
    library}.each do |mod|
  require "app/models/#{mod}"
end
