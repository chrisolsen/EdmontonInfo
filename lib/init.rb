require "dm-core"
require "dm-timestamps"
require "dm-migrations"
require "dm-sqlite-adapter"
require "dm-serializer"
require "dm-types"
require "json"

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
