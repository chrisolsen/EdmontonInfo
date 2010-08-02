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
  property :number,         String
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

    # manual updates
    FireStation.first(:name => "1").update(:number => "1", :name => "Headquarters")
    FireStation.first(:name => "2").update(:number => "2", :name => "Downtown")
    FireStation.first(:name => "3").update(:number => "3", :name => "University")
    FireStation.first(:name => "4").update(:number => "4", :name => "Jasper Place")
    FireStation.first(:name => "5").update(:number => "5", :name => "Norwood")
    FireStation.first(:name => "6").update(:number => "6", :name => "Mill Creek")
    FireStation.first(:name => "7").update(:number => "7", :name => "Highlands")
    FireStation.first(:name => "8").update(:number => "8", :name => "Hagmann")
    FireStation.first(:name => "9").update(:number => "9", :name => "Roper Station")
    FireStation.first(:name => "10").update(:number => "10", :name => "Lauderdale")
    FireStation.first(:name => "11").update(:number => "11", :name => "Capilano")
    FireStation.first(:name => "12").update(:number => "12", :name => "Meadowlark")
    FireStation.first(:name => "13").update(:number => "13", :name => "Rainbow Valley")
    FireStation.first(:name => "14").update(:number => "14", :name => "Londonderry")
    FireStation.first(:name => "15").update(:number => "15", :name => "Coronet")
    FireStation.first(:name => "16").update(:number => "16", :name => "Mill Woods")
    FireStation.first(:name => "17").update(:number => "17", :name => "Castle Downs")
    FireStation.first(:name => "18").update(:number => "18", :name => "Clareview")
    FireStation.first(:name => "19").update(:number => "19", :name => "Callingwood")
    FireStation.first(:name => "20").update(:number => "20", :name => "Kaskitayo")
    FireStation.first(:name => "21").update(:number => "21", :name => "")
    FireStation.first(:name => "22").update(:number => "22", :name => "Oliver")
    FireStation.first(:name => "23").update(:number => "23", :name => "Morin")
    FireStation.first(:name => "24").update(:number => "24", :name => "Terwillegar")
    FireStation.first(:name => "25").update(:number => "25", :name => "Lake District")
    FireStation.first(:name => "26").update(:number => "26", :name => "Meadows")
  end
  
end
