require 'net/http'
require 'rexml/document'

class School 
  include DataMapper::Resource

  property :id,           Serial
  property :longitude,    Float, :required => true
  property :latitude,     Float, :required => true
  property :timestamp,    DateTime
  property :entityid,     String

  property :school_name,  String
  property :address,      String
  property :postal_code,  String, :length => 7
  property :ward,         String
  property :website,      String
  property :phone_number, String, :length => 15
  property :fax_number,   String, :length => 15
  property :email_address,String
  property :grade_level,  String
  property :programs,     String

  property :school_type, Enum[:catholic, :other]
end

module SchoolData 

  def self.import
    urls = [
      "http://datafeed.edmonton.ca/v1/coe/EdmontonCatholicSchools",
      "http://datafeed.edmonton.ca/v1/coe/EdmontonPublicSchools"
    ]

    urls.each_with_index do |url, index|
      xml_data = Net::HTTP.get_response(URI.parse(url)).body
      doc = REXML::Document.new(xml_data)

      attr_names = %w[
        entityid   
        latitude    
        longitude   
        school_name 
        address     
        postal_code 
        ward        
        website     
        phone_number
        fax_number  
        email_address
        grade_level 
        programs    
      ]

      doc.elements.each("feed/entry/content/m:properties") do |property|
       
        begin
          attr_params = {}
          attr_names.each do |name| 
            e = property.get_elements("d:#{name}").first
            attr_params[name] = e.nil? ? "" : e.text
          end

          School.create(attr_params.merge(
            "school_type" => index == 0 ? "catholic" : "other",
            "timestamp" => property.get_elements("d:Timestamp").first.text
          ))
        rescue
          # do nothing
        end

      end # doc.elements
      
    end # urls
  end


end
