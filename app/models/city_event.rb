require 'net/http'
require "ri_cal"
require "dm-timestamps"

class CityEvent 
  include DataMapper::Resource

  property :id,           Serial
  property :name,         String, :length => 255
  property :location,     String, :length => 255
  property :note,         Text
  property :starts_at,    DateTime
  property :ends_at,      DateTime

  property :created_at,   DateTime
  property :updated_at,   DateTime
end

module CityEventData 

  def self.import
    url = "http://www.trumba.com/calendars/city-of-edmonton-calendar.ics"
    ical_data = Net::HTTP.get_response(URI.parse(url)).body
    calendar = RiCal.parse_string( ical_data )

    calendar.each do |day|
      day.subcomponents["VEVENT"].each do |event|
        starts_at = event.dtstart_property.to_ri_cal_date_time_value.to_datetime
        ends_at = event.dtend_property.to_ri_cal_date_time_value.to_datetime
        name = event.summary_property
        location = event.location_property
        note = event.description_property

        existing_event = CityEvent.first(:name => name.value)
        if existing_event.nil?
          e = CityEvent.create(
            :name => name.nil? ? nil : name.value, 
            :location => location.nil? ? nil : location.value, 
            :note => note.nil? ? nil : note.value, 
            :starts_at => starts_at,
            :ends_at => ends_at
          )
        else
          # update the start or end date
          existing_event.ends_at = ends_at if existing_event.ends_at < ends_at
          existing_event.starts_at = starts_at if existing_event.starts_at > starts_at
          existing_event.save
        end
      end
    end
  end

end
