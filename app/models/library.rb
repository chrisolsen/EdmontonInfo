require 'net/http'
require 'rexml/document'

class Library 
  include DataMapper::Resource

  property :id,           Serial
  property :longitude,    Float, :required => true
  property :latitude,     Float, :required => true
  property :timestamp,    DateTime
  property :entityid,     String

  property :address,      String
  property :postal_code,  String, :length => 7
  property :branch,       String
  property :phone_number, String
  property :url,          String
end

module LibraryData 

  def self.import
    url = "http://datafeed.edmonton.ca/v1/coe/Libraries"
    xml_data = Net::HTTP.get_response(URI.parse(url)).body
    doc = REXML::Document.new(xml_data)

    attr_names = %w[
      entityid   
      latitude    
      longitude   
      address     
      postal_code 
      branch
    ]

    doc.elements.each("feed/entry/content/m:properties") do |property|
     
      begin
        attr_params = {}
        attr_names.each do |name| 
          e = property.get_elements("d:#{name}").first
          attr_params[name] = e.nil? ? "" : e.text
        end

        Library.create(attr_params.merge(
          "timestamp" => property.get_elements("d:Timestamp").first.text
        ))
       
      rescue
        # do nothing
      end
    end

    Library.first(:branch => "Calder Branch").update(:phone_number => "(780) 496-7090", :url => "http://www.epl.ca/EPLBranchesDetail.cfm?id=CALDER")
    Library.first(:branch => "Capilano Branch").update(:phone_number => "(780) 496-1802", :url => "http://www.epl.ca/EPLBranchesDetail.cfm?id=CAPILANO")
    Library.first(:branch => "Castle Downs Branch").update(:phone_number => "(780) 496-1804", :url => "http://www.epl.ca/EPLBranchesDetail.cfm?id=CASTLEDOWNS")
    Library.first(:branch => "Highlands Branch").update(:phone_number => "(780) 496-1806", :url => "http://www.epl.ca/EPLBranchesDetail.cfm?id=HIGHLANDS")
    Library.first(:branch => "Idylwylde Branch").update(:phone_number => "(780) 496-1808", :url => "http://www.epl.ca/EPLBranchesDetail.cfm?id=IDYLWYLDE")
    Library.first(:branch => "Jasper Place Branch").update(:phone_number => "(780) 496-1810", :url => "http://www.epl.ca/EPLBranchesDetail.cfm?id=JASPER")
    Library.first(:branch => "Lois Hole Library").update(:phone_number => "(780) 442-0888", :url => "http://www.epl.ca/EPLBranchesDetail.cfm?id=LOISHOLE")
    Library.first(:branch => "Londonderry Branch").update(:phone_number => "(780) 496-1814", :url => "http://www.epl.ca/EPLBranchesDetail.cfm?id=LONDONDERRY")
    Library.first(:branch => "Mill Woods Branch").update(:phone_number => "(780) 496-1818", :url => "http://www.epl.ca/EPLBranchesDetail.cfm?id=MILLWOODS")
    Library.first(:branch => "Penny McKee - Abbottsfield Branch").update(:phone_number => "(780) 496-7839", :url => "http://www.epl.ca/EPLBranchesDetail.cfm?id=ABBOTSFIELD")
    Library.first(:branch => "Riverbend Branch").update(:phone_number => "(780) 944-5311", :url => "http://www.epl.ca/EPLBranchesDetail.cfm?id=RIVERBEND")
    Library.first(:branch => "Sprucewood Branch").update(:phone_number => "(780) 496-7099", :url => "http://www.epl.ca/EPLBranchesDetail.cfm?id=SPRUCEWOOD")
    Library.first(:branch => "Stanley A. Milner Library").update(:phone_number => "(780) 496-7000", :url => "http://www.epl.ca/EPLBranchesDetail.cfm?id=DOWNTOWN")
    Library.first(:branch => "Strathcona Branch").update(:phone_number => "(780) 496-1828", :url => "http://www.epl.ca/EPLBranchesDetail.cfm?id=STRATHCONA")
    Library.first(:branch => "Whitemud Crossing Branch").update(:phone_number => "(780) 496-1822", :url => "http://www.epl.ca/EPLBranchesDetail.cfm?id=WHITEMUD")
    Library.first(:branch => "Woodcroft Branch").update(:phone_number => "(780) 496-1830", :url => "http://www.epl.ca/EPLBranchesDetail.cfm?id=WOODCROFT")
    Library.first(:branch => "eplGo University of Alberta").update(:phone_number => "(780) 248-1662", :url => "http://www.epl.ca/EPLBranchesDetail.cfm?id=CAMERON")
  end
  
end
