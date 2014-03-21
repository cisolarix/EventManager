require 'csv'
require 'sunlight/congress'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

content = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol if File.exists? "event_attendees.csv"
content.each do |row|
  name = row[:first_name]
  zipcode = clean_zipcode row[:zipcode]
  legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
  legislators_names = legislators.map {|l| "#{l.first_name} #{l.last_name}"}
  puts "#{name}\t\t\t#{zipcode} #{legislators_names}"
end