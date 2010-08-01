require 'net/http'
require 'rexml/document'

class RecFacility 
  include DataMapper::Resource

  property :id,           Serial
  property :longitude,    Float, :required => true
  property :latitude,     Float, :required => true
  property :timestamp,    DateTime
  property :entityid,     String

  property :type,         String
  property :name,         String
  property :address,      String
  property :phone_number, String
  property :url,          String
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

    RecFacility.first(:name => "A.C.T. Aquatics and Recreation Centre").update(:address => "2909 113 Avenue", :phone_number => "(780) 496-1494")
    RecFacility.first(:name => "Bill Hunter Arena").update(:address => "9200 163 ST", :phone_number => "(780) 944-7443")
    RecFacility.first(:name => "Bonnie Doon Leisure Centre").update(:address => "8648 81 St NW", :phone_number => "(780) 496-1915")
    RecFacility.first(:name => "Borden Park Outdoor Swimming Pool").update(:address => "11200 74 Street", :phone_number => "(780) 944-7521")
    RecFacility.first(:name => "Callingwood Recreation Centre").update(:address => "17740 69 Avenue Northwest", :phone_number => "(780) 944-7427")
    RecFacility.first(:name => "Castle Downs Recreation Centre").update(:address => "11520 153 Avenue Northwest", :phone_number => "(780) 944-7550")
    RecFacility.first(:name => "Clareview Recreation Centre").update(:address => "3804 139 Avenue Northwest", :phone_number => "(780) 496-6990")
    RecFacility.first(:name => "Commonwealth Stadium").update(:address => "11000 Stadium Road Northwest", :phone_number => "(780) 448-3757")
    RecFacility.first(:name => "Confederation Arena").update(:address => "11204 43 AVE", :phone_number => "(780) 496-1488")
    RecFacility.first(:name => "Confederation Leisure Centre").update(:address => "11204 43 AVE", :phone_number => "(780) 496-1488")
    RecFacility.first(:name => "Coronation Arena").update(:address => "13500 112 Ave", :phone_number => "780-944-7441	")
    RecFacility.first(:name => "Crestwood Arena").update(:address => "9940 147 ST NW", :phone_number => "(780) 944-7440")
    RecFacility.first(:name => "Donnan Arena").update(:address => "9105 80 AVE", :phone_number => "780-944-7422")
    RecFacility.first(:name => "Eastglen Leisure Centre").update(:address => "11410 68 St", :phone_number => "(780) 496-7384")
    RecFacility.first(:name => "Fred Broadstock Outdoor Swimming Pool").update(:address => "15720-105 Avenue", :phone_number => "780-496-8390")
    RecFacility.first(:name => "Glengarry Arena").update(:address => "13340 85 Street Northwest", :phone_number => "(780) 944-7437")
    RecFacility.first(:name => "Grand Trunk Fitness and Leisure Centre").update(:address => "13025 112 Street", :phone_number => "(780) 496-8761")
    RecFacility.first(:name => "Hardisty Fitness and Leisure Centre").update(:address => "10535 65 Street Northwest", :phone_number => "(780) 496-1493")
    RecFacility.first(:name => "Jasper Place Fitness and Leisure Centre").update(:address => "9200 163 Street Northwest", :phone_number => "(780) 496-1411")
    RecFacility.first(:name => "Kenilworth Arena").update(:address => "8313 68A Street", :phone_number => "(780) 944-7410")
    RecFacility.first(:name => "Kinsmen Sports Centre").update(:address => "9100 Walterdale Hill Northwest", :phone_number => "(780) 944-7400")
    RecFacility.first(:name => "Kinsmen Twin Arenas").update(:address => "1979 111 ST NW", :phone_number => "(780) 434-9332")
    RecFacility.first(:name => "Londonderry Arena").update(:address => "14520 66 Street", :phone_number => "780-428-4879")
    RecFacility.first(:name => "Londonderry Fitness and Leisure Centre").update(:address => "14528 66 Street Northwest", :phone_number => "(780) 496-7342")
    RecFacility.first(:name => "Michael Cameron Arena").update(:address => "10404 56 Street", :phone_number => "(780) 944-7418")
    RecFacility.first(:name => "Mill Creek Outdoor Swimming Pool").update(:address => "8200 95a Street", :phone_number => "(780) 944-7415")
    RecFacility.first(:name => "O'Leary Fitness and Leisure Centre").update(:address => "8804 132 Avenue Northwest", :phone_number => "(780) 496-7373")
    RecFacility.first(:name => "Oliver Arena").update(:address => "10335 119 Street", :phone_number => "780-944-7434")
    RecFacility.first(:name => "Oliver Outdoor Swimming Pool").update(:address => "10315 119 Street Northwest", :phone_number => "(780) 944-7416")
    RecFacility.first(:name => "Peter Hemingway Fitness and Leisure Centre").update(:address => "13808 111 Avenue Northwest", :phone_number => "(780) 496-1401")
    RecFacility.first(:name => "Queen Elizabeth Outdoor Swimming Pool").update(:address => "9100 Walterdale Hill", :phone_number => "(780) 944-7400")
    RecFacility.first(:name => "Russ Barnes Arena").update(:address => "6725 121 Avenue", :phone_number => "780-944-7554")
    RecFacility.first(:name => "South Side Arena").update(:address => "10525 72 Ave NW", :phone_number => "780-944-7406")
    RecFacility.first(:name => "Tipton Arena").update(:address => "10828 80 Avenue", :phone_number => "780-496-7388")
    RecFacility.first(:name => "Westwood Arena").update(:address => "12040 97 Street", :phone_number => "780-428-3729")
  end
  
end
