require "lib/init"

configure :development do
  set :logging, true
  DataMapper::Logger.new(STDOUT, :debug)
end

configure :production do 
  disable :run, :reload
end

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/config/edmonton.db")

get "/" do
  "EdmontonInfoApp.com"
end

get "/parks" do
  Park.all.to_json
end

get "/community_league_centers" do
  CommunityLeagueCenter.all.to_json
end

get "/schools" do
  School.all.to_json
end

get "/libraries" do
  Library.all.to_json
end

get "/fire_stations" do
  FireStation.all(:name.not => "").to_json
end

get "/police_stations" do
  PoliceStation.all.to_json
end

get "/rec_facilities" do
  RecFacility.all.to_json
end

get "/city_events" do
  CityEvent.all.to_json
end

get "/city_events/sync/:date" do
  date = DateTime.parse( params[:date] )
  events = CityEvent.all( :updated_at.gt => date )
  events.nil? ? "" : events.to_json
end

get "/fields" do
  Field.current_status.to_json
end
