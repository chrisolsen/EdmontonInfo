require 'net/http'
require 'rexml/document'

class CommunityLeagueCenter
  include DataMapper::Resource

  property :id,           Serial
  property :name,         String, :required => true, :unique => true
  property :address,      String
  property :phone_number, String
  property :url,          String
  property :longitude,    Float, :required => true
  property :latitude,     Float, :required => true
  property :timestamp,    String
  property :entity_id,    String
  
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

    CommunityLeagueCenter.first(:name => "Alberta Avenue").update(:address => "9210 118 Avenue Northwest", :url => "http://www.albertaave.org/", :phone_number => "(780) 477-2773")
    CommunityLeagueCenter.first(:name => "Aldergrove").update(:address => "8535-182 Street", :url => "http://www.aldergroveonline.com/", :phone_number => "780-481-1588")
    CommunityLeagueCenter.first(:name => "Allendale").update(:address => "11104 65 AVE NW", :url => "http://allendalecommunity.ca/", :phone_number => "(780) 434-2870")
    CommunityLeagueCenter.first(:name => "Argyll").update(:address => "Lakewood Road North Northwest", :url => "http://www.argyllcl.ab.ca/", :phone_number => "(780) 466-8166")
    CommunityLeagueCenter.first(:name => "Aspen Gardens").update(:address => "12015-39A avenue", :url => "http://www.aspengardens.ca/", :phone_number => "(780) 434-2687")
    CommunityLeagueCenter.first(:name => "Athlone").update(:address => "13010 - 129 Street", :url => "http://www.athlone.ca/", :phone_number => "(780) 451-4016")
    CommunityLeagueCenter.first(:name => "Avonmore").update(:address => "7902-73rd Avenue", :url => "http://www.avonmore.org/", :phone_number => "(780) 465-1941")
    CommunityLeagueCenter.first(:name => "Bannerman").update(:address => "14034 23 ST NW", :url => "http://bannermancommunity.com/", :phone_number => "(780) 476-8603")
    CommunityLeagueCenter.first(:name => "Baturyn").update(:address => "10505-172ave", :url => "http://www.baturyn.ca/", :phone_number => "(780) 473-1915")
    CommunityLeagueCenter.first(:name => "Beacon Heights").update(:address => "12037 43 ST", :url => "http://www.beaconheightscommunityleague.com/", :phone_number => "(780) 477-2475")
    CommunityLeagueCenter.first(:name => "Belgravia").update(:address => "11341 78 AVE NW", :url => "http://belgraviaedmonton.ca/", :phone_number => "(780) 436-2735")
    CommunityLeagueCenter.first(:name => "Bellevue Community League").update(:name => "Bellevue", :address => "7308 112 Avenue", :url => "", :phone_number => "(780) 477-8004")
    CommunityLeagueCenter.first(:name => "Belmead").update(:address => "9109 182 ST NW", :url => "", :phone_number => "(780) 489-7939")
    CommunityLeagueCenter.first(:name => "Belvedere").update(:address => "13223 - 62 Street", :url => "http://www.belvederecl.com/Welcome/tabid/510/ctl/Privacy/Default.aspx", :phone_number => "780-476-1224")
    CommunityLeagueCenter.first(:name => "Beverly Heights").update(:address => "4209 - 111 Avenue", :url => "", :phone_number => "(780) 471-5459")
    CommunityLeagueCenter.first(:name => "Blue Quill").update(:address => "11304 - 25 Avenue", :url => "http://www.bqcl.org", :phone_number => "780-438-3366")
    CommunityLeagueCenter.first(:name => "Bonnie Doon").update(:address => "9240 93 Street Northwest", :url => "http://www.bonniedoon.ca/", :phone_number => "(780) 466-0202")
    CommunityLeagueCenter.first(:name => "Boyle Street").update(:address => "9515 - 104 Avenue", :url => "http://boylestreetcommunityleague.ca/", :phone_number => "(780) 422-5857")
    CommunityLeagueCenter.first(:name => "Britannia-Youngstown").update(:address => "15927 - 105 Avenue", :url => "", :phone_number => "780-486-1887")
    CommunityLeagueCenter.first(:name => "Burnewood").update(:address => "4118 - 41 Avenue", :url => "http://www.burnewood.ca/", :phone_number => "780-465-9814")
    CommunityLeagueCenter.first(:name => "Caernarvon").update(:address => "14830 - 118 Street", :url => "http://www.caernarvoncommunity.org/", :phone_number => "780-456-3435")
    CommunityLeagueCenter.first(:name => "Calder").update(:address => "12721 - 120 Street", :url => "", :phone_number => "(780) 451-4016")
    CommunityLeagueCenter.first(:name => "Canora").update(:address => "10425 - 152 Street", :url => "", :phone_number => "780-489-6007")
    CommunityLeagueCenter.first(:name => "Capilano").update(:address => "10810 - 54 Street", :url => "http://www.capilano.info/", :phone_number => "780-463-9338")
    CommunityLeagueCenter.first(:name => "Carlisle").update(:address => "14240 - 117 Street", :url => "", :phone_number => "(780) 456-3434")
    CommunityLeagueCenter.first(:name => "Central McDougall Community League").update(:name => "Central McDougall", :address => "10630 – 109 Avenue", :url => "http://www.centralmcdougallcommunity.org/", :phone_number => "780-990-1340")
    CommunityLeagueCenter.first(:name => "Cloverdale").update(:address => "9411 - 97 Avenue", :url => "http://www.cloverdalecommunity.com/", :phone_number => "780-453-6962")
    CommunityLeagueCenter.first(:name => "Crestwood").update(:address => "14325 - 96 Avenue", :url => "http://www.crestwood.ab.ca/", :phone_number => "780-452-4254")
    CommunityLeagueCenter.first(:name => "Delwood").update(:address => "7515 Delwood Road", :url => "http://www.delwood.ca/", :phone_number => "780-476-2142")
    CommunityLeagueCenter.first(:name => "Dovercourt").update(:address => "13510 Dovercourt Avenue", :url => "http://www.dovercourt.net/", :phone_number => "780-454-2694")
    CommunityLeagueCenter.first(:name => "Duggan").update(:address => "3728 - 106 Street", :url => "http://www.duggancommunity.ab.ca/", :phone_number => "780-436-6987")
    CommunityLeagueCenter.first(:name => "Dunluce").update(:address => "11620 - 162 Avenue", :url => "http://www.dunlucecl.ca/", :phone_number => "780-457-4342")
    CommunityLeagueCenter.first(:name => "Elmwood").update(:address => "16415 - 83 Avenue", :url => "", :phone_number => "780-489-2179")
    CommunityLeagueCenter.first(:name => "Elmwood Park").update(:address => "12505 - 75 Street", :url => "", :phone_number => "780-479-1035")
    CommunityLeagueCenter.first(:name => "Empire Park").update(:address => "4804 - 107 Street", :url => "http://www.empirepark.ca/", :phone_number => "780-434-4226")
    CommunityLeagueCenter.first(:name => "Evansdale").update(:address => "9111 - 150 Avenue", :url => "http://www.evansdale.ca/", :phone_number => "780-457-0948")
    CommunityLeagueCenter.first(:name => "Forest Heights").update(:address => "10150 - 80 Street", :url => "http://www.forestterrace.org/", :phone_number => "780-468-1798")
    CommunityLeagueCenter.first(:name => "Fraser").update(:address => "14720 - 21 Street", :url => "", :phone_number => "(780) 475-7904")
    CommunityLeagueCenter.first(:name => "Fulton Place").update(:address => "6115 Fulton Road", :url => "http://www.fultonplace.org/", :phone_number => "(780) 466-8140")
    CommunityLeagueCenter.first(:name => "Glengarry").update(:address => "13325 - 89 Street", :url => "http://www.glengarrycl.com/", :phone_number => "780-473-2318")
    CommunityLeagueCenter.first(:name => "Glenora").update(:address => "10426 - 136 Street", :url => "http://www.glenoracommunity.com/", :phone_number => "(780) 452-1790")
    CommunityLeagueCenter.first(:name => "Glenwood").update(:address => "16430 - 97 Avenue", :url => "http://glenwoodcommunityleague.wordpress.com/", :phone_number => "780-489-7571")
    CommunityLeagueCenter.first(:name => "Gold Bar").update(:address => "4620 - 105 Avenue", :url => "http://www.goldbarcl.com/", :phone_number => "(780) 469-6288")
    CommunityLeagueCenter.first(:name => "Grandview Hts.").update(:address => "12603 - 63 Avenue", :url => "http://www.grandviewcommunity.ca/", :phone_number => "780-435-0208")
    CommunityLeagueCenter.first(:name => "Greenfield").update(:address => "12603 - 63 Avenue", :url => "http://www.grandviewcommunity.ca/", :phone_number => "780-435-0208")
    CommunityLeagueCenter.first(:name => "Grovenor").update(:address => "14325 - 104 Avenue", :url => "http://www.grovenor.ca/", :phone_number => "780-453-1440")
    CommunityLeagueCenter.first(:name => "Hairsine").update(:address => "3120 - 139 Avenue", :url => "", :phone_number => "780-475-7356")
    CommunityLeagueCenter.first(:name => "Hazeldean").update(:address => "9630 - 66 Avenue NW", :url => "http://www.hazeldean.org/", :phone_number => "780-439-0847")
    CommunityLeagueCenter.first(:name => "High Park").update(:address => "11032 - 154 Street", :url => "http://www.highparkcommunity.com/", :phone_number => "780-484-4646")
    CommunityLeagueCenter.first(:name => "Highlands And District Community League").update(:name => "Highlands And District", :address => "6112 - 113 Avenue", :url => "http://www.highlandscommunity.ca/", :phone_number => "780-477-5350")
    CommunityLeagueCenter.first(:name => "Holyrood").update(:address => "9411 Holyrood Road", :url => "http://www.holyroodleague.org/", :phone_number => "(780) 465-1577")
    CommunityLeagueCenter.first(:name => "Homesteader").update(:address => "575 Hermitage Road", :url => "http://www.homesteadercommunityleague.ca/", :phone_number => "780-475-0992")
    CommunityLeagueCenter.first(:name => "Idywylde").update(:name => "Idylwylde", :address => "8631 - 81 Street", :url => "http://idylwylde.org/", :phone_number => "780-466-7383")
    CommunityLeagueCenter.first(:name => "Inglewood").update(:address => "12515 - 116 Avenue", :url => "http://www.inglewoodcl.com/", :phone_number => "780-451-4206")
    CommunityLeagueCenter.first(:name => "Jasper Park").update(:address => "8751- 153 Street", :url => "", :phone_number => "780-484-8749")
    CommunityLeagueCenter.first(:name => "Kennilworth").update(:name => "Kenilworth", :address => "7104 - 87 Avenue", :url => "http://sites.google.com/site/kenilworthcommunityleague/", :phone_number => "780-469-1711")
    CommunityLeagueCenter.first(:name => "Kensington").update(:address => "12130 - 134A Avenue", :url => "", :phone_number => "780-454-6885")
    CommunityLeagueCenter.first(:name => "Kilkenny").update(:address => "14910 - 72 Street NW", :url => "http://www.kilkenny.ab.ca/", :phone_number => "780-478-2481")
    CommunityLeagueCenter.first(:name => "Killarney Community League").update(:name => "Killarney", :address => "8720 - 130A Avenue", :url => "http://www.killarneycl.com/", :phone_number => "780-475-2029")
    CommunityLeagueCenter.first(:name => "King Edward Park").update(:address => "7708 - 85 Street", :url => "http://kingedwardpark.org/", :phone_number => "(780) 465-1575")
    CommunityLeagueCenter.first(:name => "Knottwood").update(:address => "445 Knottwood Road West", :url => "http://www.millwoods.org/kcl.html", :phone_number => "780-462-7549")
    CommunityLeagueCenter.first(:name => "La Perle").update(:address => "18611 - 97A Avenue", :url => "http://www.laperle-community.ca/", :phone_number => "780-486-4426")
    CommunityLeagueCenter.first(:name => "Lago Lindo and Klravatten").update(:address => "17223 - 95 Street", :url => "http://www.lagolindo.ca/", :phone_number => "780-457-0574")
    CommunityLeagueCenter.first(:name => "Lakewood").update(:address => "260 Lakewood Road East", :url => "http://www.millwoods.org/lwcl.html", :phone_number => "780-463-3617")
    CommunityLeagueCenter.first(:name => "Lansdowne").update(:address => "12323 - 51 Avenue", :url => "", :phone_number => "(780) 437-2441")
    CommunityLeagueCenter.first(:name => "Lauderdale").update(:address => "12937 - 107 Street", :url => "", :phone_number => "780-475-8664")
    CommunityLeagueCenter.first(:name => "Laurier Heights").update(:address => "14405 - 85 Avenue", :url => "http://www.laurierheightscommunity.ca/", :phone_number => "780-483-5503")
    CommunityLeagueCenter.first(:name => "Leefield").update(:address => "7910 - 36 Avenue", :url => "http://www.leefield.ca/", :phone_number => "780-463-2456")
    CommunityLeagueCenter.first(:name => "Lendrum").update(:address => "11335 - 57 Avenue", :url => "http://www.lendrumliving.com/", :phone_number => "(780) 434-2049")
    CommunityLeagueCenter.first(:name => "Lessard").update(:address => "17404 - 57 Avenue", :url => "http://www.lessardcommunity.ca/", :phone_number => "780-481-6579")
    CommunityLeagueCenter.first(:name => "Lorelie/Beaumaris").update(:address => "16220 - 103 Street", :url => "http://www.lorelei-beaumaris.com/", :phone_number => "780-413-7190")
    CommunityLeagueCenter.first(:name => "Lynnwood").update(:address => "15525 - 84 Avenue", :url => "http://www.lynnwoodcommunity.com/", :phone_number => "780-484-4893")
    CommunityLeagueCenter.first(:name => "Malmo").update(:address => "11525 - 48 Avenue", :url => "http://www.malmoplains.com/", :phone_number => "780-435-1588")
    CommunityLeagueCenter.first(:name => "Mayfield").update(:address => "10941 - 161 Street", :url => "", :phone_number => "780-483-4675")
    CommunityLeagueCenter.first(:name => "McLeod Community League").update(:name => "McLeod", :address => "14715 - 59 Street", :url => "http://www.mcleodcommunityleague.ca/", :phone_number => "780-475-5712")
    CommunityLeagueCenter.first(:name => "McQueen").update(:address => "10825 McQueen Road", :url => "http://mcqueen.yourcommunityleague.com/", :phone_number => "780-455-3406")
    CommunityLeagueCenter.first(:name => "Meadowlark").update(:address => "15961 - 92 Avenue", :url => "http://www.meadowlarkcl.net/", :phone_number => "780-484-1287")
    CommunityLeagueCenter.first(:name => "Millhurst").update(:address => "5811 - 19A Avenue", :url => "http://www.millwoods.org/mhcl.html", :phone_number => "780-462-3493")
    CommunityLeagueCenter.first(:name => "Montrose Community League (1992)").update(:name => "Montrose", :address => "5920 - 119 Avenue", :url => "http://www.montrosecommunity.com/", :phone_number => "780-471-2758")
    CommunityLeagueCenter.first(:name => "N. Millbourne").update(:name => "North Millbourne", :address => "980 Millbourne Road East", :url => "http://www.millwoods.org/nmcl.html", :phone_number => "780-914-3390")
    CommunityLeagueCenter.first(:name => "North Glenora").update(:address => "13535 - 109A Avenue", :url => "http://www.ngcl.org/", :phone_number => "780-452-6610")
    CommunityLeagueCenter.first(:name => "Ogilvie Ridge Community League").update(:name => "Ogilvie Ridge", :address => "214 Omand Drive", :url => "http://www.whitemudcreek.ca", :phone_number => "780-437-6305")
    CommunityLeagueCenter.first(:name => "Oliver").update(:address => "10326 - 118 Street", :url => "", :phone_number => "(780) 488-0803")
    CommunityLeagueCenter.first(:name => "Ottewell").update(:address => "5920 - 93A Avenue", :url => "http://www.ottewell.org/", :phone_number => "780-469-0093")
    CommunityLeagueCenter.first(:name => "Parkallen").update(:address => "11104 - 65 Avenue", :url => "http://www.parkallen.org/cms/", :phone_number => "780-438-2287")
    CommunityLeagueCenter.first(:name => "Parkdale/Cromdale").update(:address => "11335 - 85 Street", :url => "http://www.parkdalecromdale.org/", :phone_number => "780-471-4410")
    CommunityLeagueCenter.first(:name => "Parkview").update(:address => "9135 - 146 Street", :url => "http://www.pvcl.ca/", :phone_number => "(780) 483-2098")
    CommunityLeagueCenter.first(:name => "Pleasantview").update(:address => "10860 - 57 Avenue", :url => "http://www.pleasantviewcommunityleague.ca/", :phone_number => "780-434-2870")
    CommunityLeagueCenter.first(:name => "Prince Charles").update(:address => "12033 - 125 Street", :url => "http://www.princecharlescommunity.ca/", :phone_number => "780-490-1154")
    CommunityLeagueCenter.first(:name => "Prince Rupert").update(:address => "11245 - 113 Street", :url => "http://www.princerupertcommunity.ca/", :phone_number => "780-455-3327")
    CommunityLeagueCenter.first(:name => "Queen Alexandra").update(:address => "10425 University Avenue", :url => "http://www.qacl.ca/", :phone_number => "780-439-9046")
    CommunityLeagueCenter.first(:name => "Queen Mary Park Community League").update(:name => "Queen Mary Park", :address => "10844 - 117 Street", :url => "http://www.qmpcommunity.org/", :phone_number => "780-447-5389")
    CommunityLeagueCenter.first(:name => "Ridgewood").update(:address => "3705 Millwoods Road East", :url => "http://www.ridgewoodcl.org/", :phone_number => "780-450-6338")
    CommunityLeagueCenter.first(:name => "Rio Terrace").update(:address => "15500 - 76 Avenue", :url => "http://www.rioterrace.ca/CMS/", :phone_number => "780-988-9417")
    CommunityLeagueCenter.first(:name => "Ritchie").update(:address => "7727 - 98 Street", :url => "", :phone_number => "780-433-7137")
    CommunityLeagueCenter.first(:name => "Riverbend (Brookside Hall)").update(:address => "258 Rhatigan Rd East", :url => "http://www.riverbendonline.ca/index.php", :phone_number => "780-437-7108")
    CommunityLeagueCenter.first(:name => "Riverbend (Hall 1)").update(:address => "5320 - 143 Street", :url => "http://www.riverbendonline.ca/index.php", :phone_number => "780-437-7108")
    CommunityLeagueCenter.first(:name => "Riverdale").update(:address => "9231 - 100 Avenue", :url => "http://www.riverdalians.net/", :phone_number => "780-421-1357")
    CommunityLeagueCenter.first(:name => "Rossdale").update(:address => "10135 - 96 Avenue", :url => "http://www.rossdaleonline.com/http://www.rossdaleonline.com/", :phone_number => "780-420-6729")
    CommunityLeagueCenter.first(:name => "Rosslyn").update(:address => "11015 - 134 Avenue", :url => "http://www.rosslyncommunity.org/", :phone_number => "780-475-4141")
    CommunityLeagueCenter.first(:name => "Royal Gardens").update(:address => "4030 - 117 Street", :url => "http://royalgardenscommunity.com/", :phone_number => "780-434-4359")
    CommunityLeagueCenter.first(:name => "Sherbrooke").update(:address => "13008 - 122 Avenue", :url => "", :phone_number => "780-453-1428")
    CommunityLeagueCenter.first(:name => "South Clareview Community League").update(:name => "South Clareview", :address => "3250 - 132A Avenue", :url => "http://www.southclareview.ca/", :phone_number => "780-473-3593")
    CommunityLeagueCenter.first(:name => "Southwood").update(:address => "1880 - 37 Street", :url => "http://www.millwoods.org/swcl.html", :phone_number => "780-461-8133")
    CommunityLeagueCenter.first(:name => "Spruce Avenue").update(:address => "10240 - 115 Avenue", :url => "http://www.spruceavenuecommunityleague.blogspot.com/", :phone_number => "780-471-1932")
    CommunityLeagueCenter.first(:name => "Steinhauer").update(:address => "10709 - 32A Avenue", :url => "http://www.ermineskincommunity.ca/", :phone_number => "780-438-6623")
    CommunityLeagueCenter.first(:name => "Strathcona Centre").update(:address => "10139 - 87 Avenue", :url => "http://www.strathconacommunity.ca/", :phone_number => "780-439-1501")
    CommunityLeagueCenter.first(:name => "Strathearn").update(:address => "8777 - 96 Avenue", :url => "http://www.strathearncommunityleague.org/", :phone_number => "780-468-6556")
    CommunityLeagueCenter.first(:name => "Twin Parks").update(:address => "20 Park Ridge Cresent", :url => "", :phone_number => "780-440-1059")
    CommunityLeagueCenter.first(:name => "WJP Sherwood").update(:name => "West Jasper/Sherwood", :address => "9620 - 152 Street", :url => "", :phone_number => "780-483-2815")
    CommunityLeagueCenter.first(:name => "Wellington").update(:address => "13440 - 132 Street", :url => "", :phone_number => "780-454-9790")
    CommunityLeagueCenter.first(:name => "West Meadowlark").update(:address => "9311 - 165 Street", :url => "http://www.wmcl.org/", :phone_number => "780-484-6132")
    CommunityLeagueCenter.first(:name => "Westmount").update(:address => "10970 - 127 Street", :url => "http://www.westmountcommunityleague.com/", :phone_number => "780-452-5165")
    CommunityLeagueCenter.first(:name => "Westridge WolfWillow").update(:address => "505 Wolf Willow Road", :url => "http://www.wwwcccl.com/", :phone_number => "780-433-8327")
    CommunityLeagueCenter.first(:name => "Westwood").update(:address => "12139 - 105 Street", :url => "", :phone_number => "(780) 474-1979")
    CommunityLeagueCenter.first(:name => "Willowby").update(:address => "6315 - 184 Street", :url => "http://www.willowbycommunityleague.com/", :phone_number => "780-481-1456")
    CommunityLeagueCenter.first(:name => "Windsor Park").update(:address => "6315 - 184 Street", :url => "http://www.willowbycommunityleague.com/", :phone_number => "780-481-1456")
    CommunityLeagueCenter.first(:name => "Woodcroft").update(:address => "13915 - 115 Avenue", :url => "http://woodcroftcl.org/", :phone_number => "780-488-6943")
    CommunityLeagueCenter.first(:name => "Woodvale").update(:address => "4540 - 50 Street", :url => "http://www.woodvale.org/", :phone_number => "780-462-2101")
    CommunityLeagueCenter.first(:name => "Yellowbird (East) Community League").update(:name => "Yellowbird (East)", :address => "10704 - 19 Avenue NW", :url => "http://www.yellowbirdcl.com/", :phone_number => "780-438-1318")
  end
  
end
