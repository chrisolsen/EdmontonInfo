require 'net/http'
require 'rexml/document'

class Park
  include DataMapper::Resource

  property :id,         Serial
  property :entity_id,  String
  property :name,       String, :unique => true, :required => true
  property :address,    String
  property :latitude,   Float, :required => true
  property :longitude,  Float, :required => true

  property :timestamp,  DateTime
end

module ParkData

  def self.import
    url = "http://datafeed.edmonton.ca/v1/coe/CityParks"
    xml_data = Net::HTTP.get_response(URI.parse(url)).body
    doc = REXML::Document.new(xml_data)

    doc.elements.each("feed/entry/content/m:properties") do |property|
      ts   = property.get_elements("d:Timestamp").first
      eid  = property.get_elements("d:entityid").first
      name = property.get_elements("d:name").first
      lat  = property.get_elements("d:latitude").first
      lng  = property.get_elements("d:longitude").first
      addr = property.get_elements("d:address").first

      # prevent duplicate names with appended numbe ie foobar 1, foobar 2
      name = name.text.match(/^(\d*\D*)/)[1].strip
     
      begin
        Park.create(
          :timestamp  => ts.nil?   ? "" : ts.text,
          :entity_id  => eid.nil?  ? "" : eid.text, 
          :name       => name.nil? ? "" : name,
          :latitude   => lat.nil?  ? "" : lat.text,
          :longitude  => lng.nil?  ? "" : lng.text, 
          :address    => addr.nil? ? "" : addr.text 
        )
      rescue
        # do nothing
      end
    end

  end # method
end
