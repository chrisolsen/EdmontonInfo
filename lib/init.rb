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
