require 'net/http'
require 'rexml/document'

class PoliceStation 
  include DataMapper::Resource

  property :id,           Serial
  property :longitude,    Float, :required => true
  property :latitude,     Float, :required => true
  property :timestamp,    DateTime
  property :entityid,     String

  property :address,      String
  property :name,         String
  property :phone_number, String
  property :url,          String
end

module PoliceStationData 

  def self.import
    url = "http://datafeed.edmonton.ca/v1/coe/PoliceStations"
    xml_data = Net::HTTP.get_response(URI.parse(url)).body
    doc = REXML::Document.new(xml_data)

    attr_names = %w[
      entityid   
      latitude    
      longitude   
      address     
      name
    ]

    doc.elements.each("feed/entry/content/m:properties") do |property|
     
      begin
        attr_params = {}
        attr_names.each do |name| 
          e = property.get_elements("d:#{name}").first
          attr_params[name] = e.nil? ? "" : e.text
        end

        PoliceStation.create(attr_params.merge(
          "timestamp" => property.get_elements("d:Timestamp").first.text
        ))
       
      rescue
        # do nothing
      end
    end

    PoliceStation.first(:name => "EPS Beverly").update(:phone_number => "780-496-8560", :url => "http://www.edmontonpolice.ca/ContactEPS/EPSPoliceStations/NorthDivision/BeverlyStation.aspx")
    PoliceStation.first(:name => "EPS Calder").update(:phone_number => "780-496-8535", :url => "http://www.edmontonpolice.ca/ContactEPS/EPSPoliceStations/NorthDivision/CalderStation.aspx")
    PoliceStation.first(:name => "EPS Eastwood").update(:phone_number => "780-496-8502", :url => "http://www.edmontonpolice.ca/ContactEPS/EPSPoliceStations/DowntownDivision/EastwoodStation.aspx")
    PoliceStation.first(:name => "EPS Fairway").update(:phone_number => "780-496-8550", :url => "http://www.edmontonpolice.ca/ContactEPS/EPSPoliceStations/SouthwestDivision/FairwayStation.aspx")
    PoliceStation.first(:name => "EPS HQ").update(:phone_number => "780-423-4567", :url => "http://www.edmontonpolice.ca/")
    PoliceStation.first(:name => "EPS McDougall").update(:phone_number => "780-496-8611", :url => "http://www.edmontonpolice.ca/ContactEPS/EPSPoliceStations/DowntownDivision/McDougallStation.aspx")
    PoliceStation.first(:name => "EPS NORTH DIV").update(:phone_number => "780-426-8100", :url => "http://www.edmontonpolice.ca/ContactEPS/EPSPoliceStations/NorthDivision.aspx")
    PoliceStation.first(:name => "EPS Namao").update(:phone_number => "780-496-8542", :url => "http://www.edmontonpolice.ca/ContactEPS/EPSPoliceStations/NorthDivision/NamaoCentreStation.aspx")
    PoliceStation.first(:name => "EPS Old Strathcona").update(:phone_number => "780-496-8565", :url => "http://www.edmontonpolice.ca/ContactEPS/EPSPoliceStations/SouthwestDivision/OldStrathconaStation.aspx")
    PoliceStation.first(:name => "EPS Ottewell").update(:phone_number => "780-496-8516", :url => "http://www.edmontonpolice.ca/ContactEPS/EPSPoliceStations/SoutheastDivision/OttewellStation.aspx")
    PoliceStation.first(:name => "EPS SOUTHEAST DIV").update(:phone_number => "780-426-8200", :url => "http://www.edmontonpolice.ca/ContactEPS/EPSPoliceStations/SoutheastDivision.aspx")
    PoliceStation.first(:name => "EPS SOUTHWEST DIV").update(:phone_number => "780-426-8300", :url => "http://www.edmontonpolice.ca/ContactEPS/EPSPoliceStations/SouthwestDivision.aspx")
    PoliceStation.first(:name => "EPS Summerlea").update(:phone_number => "780-496-8525", :url => "http://www.edmontonpolice.ca/ContactEPS/EPSPoliceStations/WestDivision/SummerleaStation.aspx")
    PoliceStation.first(:name => "EPS WEST DIV").update(:phone_number => "780-426-8000", :url => "http://www.edmontonpolice.ca/ContactEPS/EPSPoliceStations/WestDivision.aspx")

  end
  
end
