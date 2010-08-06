require "nokogiri"
require "open-uri"

class Field 
  include DataMapper::Resource

  property :id,        Serial
  property :name,      String, :required => true
  property :state,     String, :required => true
  property :timestamp, String
  property :current,   Boolean, :default => true

  property :created_at, DateTime

  URL = "http://coewebapps.edmonton.ca/external/CommunityServices/SportsFieldStatus.aspx"

  # obtains the latest field states from the web
  def self.sync
    doc = Nokogiri::HTML( open(URL) )
    fields = []
    timestamp = ""
    field_name = ""

    doc.css("#pnlDisplayWebForm table").each_with_index do |table, table_index|

      if table_index == 0
        table.css("#lblPageLastUpdated").each do |cell|
          timestamp = cell.text
        end
      elsif table_index == 1
        table.css("tr").each do |row|
          # City of Edmonton doesn't use a thead tag for the headers
          row.css("td").each_with_index do |cell, cell_index|
            if cell_index == 0
              field_name = cell.text.strip
            elsif cell_index == 1
              fields << Field.new(:name => field_name, :state => cell.text.strip, :timestamp => timestamp)
            end
          end
        end
      end
    end # end of doc

    Field.destroy
    fields.each do |field|
      field.save
    end
    
    # # update db if the field status has been updated
    #     latest_field_status = Field.first(:order => :id.desc)
    #     if latest_field_status.nil? || fields.first.timestamp != latest_field_status.timestamp 
    #       fields.each do |field|
    #         field.save
    #       end
    #     end

  end # sync 

  def self.current_status
    fields = Field.all(:current => true, :limit => 3)
  end
  
end
