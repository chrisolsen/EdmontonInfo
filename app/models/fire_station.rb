require 'net/http'
require 'rexml/document'

class FireStation 
  include DataMapper::Resource

  property :id,           Serial
  property :longitude,    Float, :required => true
  property :latitude,     Float, :required => true
  property :timestamp,    DateTime
  property :entityid,     String

  property :address,      String
  property :name,         String
  property :is_ems_combined,  String, :length => 7
end

module FireStationData 

  def self.import
    url = "http://datafeed.edmonton.ca/v1/coe/FireStations"
    xml_data = Net::HTTP.get_response(URI.parse(url)).body
    doc = REXML::Document.new(xml_data)

    attr_names = %w[
      entityid   
      latitude    
      longitude   
      address     
      name
      is_ems_combined
    ]

    doc.elements.each("feed/entry/content/m:properties") do |property|
     
      begin
        attr_params = {}
        attr_names.each do |name| 
          e = property.get_elements("d:#{name}").first
          attr_params[name] = e.nil? ? "" : e.text
        end

        FireStation.create(attr_params.merge(
          "timestamp" => property.get_elements("d:Timestamp").first.text
        ))
       
      rescue
        # do nothing
      end
    end
  end
  
end
