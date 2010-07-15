require 'net/http'
require 'rexml/document'

class RecFacility 
  include DataMapper::Resource

  property :id,           Serial
  property :longitude,    Float, :required => true
  property :latitude,     Float, :required => true
  property :timestamp,    DateTime
  property :entityid,     String

  property :type,      String
  property :name,         String
end

module RecFacilityData 

  def self.import
    url = "http://datafeed.edmonton.ca/v1/coe/RecreationFacilities"
    xml_data = Net::HTTP.get_response(URI.parse(url)).body
    doc = REXML::Document.new(xml_data)

    attr_names = %w[
      entityid   
      latitude    
      longitude   
      name
      type
    ]

    doc.elements.each("feed/entry/content/m:properties") do |property|
     
      begin
        attr_params = {}
        attr_names.each do |name| 
          e = property.get_elements("d:#{name}").first
          attr_params[name] = e.nil? ? "" : e.text
        end

        RecFacility.create(attr_params.merge(
          "timestamp" => property.get_elements("d:Timestamp").first.text
        ))
       
      rescue
        # do nothing
      end
    end
  end
  
end
