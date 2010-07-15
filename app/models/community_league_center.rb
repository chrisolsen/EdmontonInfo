require 'net/http'
require 'rexml/document'

class CommunityLeagueCenter
  include DataMapper::Resource

  property :id,         Serial
  property :name,       String, :required => true, :unique => true
  property :longitude,  Float, :required => true
  property :latitude,   Float, :required => true
  property :timestamp,  String
  property :entity_id,  String
  
end

module CommunityLeagueCenterData

  def self.import
    url = "http://datafeed.edmonton.ca/v1/coe/CommunityLeagueCentres"
    xml_data = Net::HTTP.get_response(URI.parse(url)).body
    doc = REXML::Document.new(xml_data)

    doc.elements.each("feed/entry/content/m:properties") do |property|
      ts   = property.get_elements("d:Timestamp").first
      eid  = property.get_elements("d:entityid").first
      name = property.get_elements("d:name").first
      lat  = property.get_elements("d:latitude").first
      lng  = property.get_elements("d:longitude").first

      begin
        CommunityLeagueCenter.create(
          :timestamp  => ts.nil?   ? "" : ts.text,
          :entity_id  => eid.nil?  ? "" : eid.text, 
          :name       => name.nil? ? "" : name.text,
          :latitude   => lat.nil?  ? "" : lat.text,
          :longitude  => lng.nil?  ? "" : lng.text
        )
      rescue
        # do nothing
      end
    end
  end
  
end
