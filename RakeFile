require "lib/init"

task :environment do
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/config/edmonton.db")
end

namespace :db do
  desc "Import data from the Edmonton site"
  task(:migrate => :environment) do
    puts "Creating Database..."

    DataMapper.auto_migrate!

    puts "Importing Park Data..."
    ParkData.import

    puts "Importing Community league center Data..."
    CommunityLeagueCenterData.import

    puts "Importing School Data..."
    SchoolData.import

    puts "Importing Library Data..."
    LibraryData.import

    puts "Importing Fire Station Data..."
    FireStationData.import

    puts "Importing Police Station Data..."
    PoliceStationData.import

    puts "Importing Rec Facility Data..."
    RecFacilityData.import

    puts "Importing City Event Data..."
    CityEventData.import
  end
  
  desc "Fix School Data"
  task(:fix_schools => :environment) do
    School.all.each do |school|
      matches = school.school_name.match(/(.*)\(Opening 2010\)/)
      unless matches.nil?
        school.update( :school_name => matches[1] ) 
        puts "Fixed #{school.school_name}"
      end
    end
  end

  namespace :sync do
    desc "Sync Edmonton Events"
    task(:events => :environment) do
      puts "Importing City Events..."
      CityEventData.import
    end

    desc "Sync Field Statuses"
    task(:fields => :environment) do
      puts "Syncing Fields..."
      Field.sync
    end
  end
end
