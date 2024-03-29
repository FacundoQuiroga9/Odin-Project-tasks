require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def clean_phone_number(number)
  clean_number = number.gsub(/\D/, '')
  if clean_number.length < 10
    return "Bad number #{clean_number}"
  elsif clean_number.length == 11
      if clean_number[0] == "1"
        return clean_number[1..-1]
      else
        return "Bad number #{clean_number}"
      end
    elsif clean_number.length > 11
      return "Bad number #{clean_number}"
  end
  return clean_number
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

def time_targeting(dates)
    hourly_record = Hash.new(0)

  dates.each do |date|
    registration_time = Time.strptime(date, "%m/%d/%y %H:%M").hour
    hourly_record[registration_time] += 1
end

main_hour = hourly_record.max_by { |hora, cantidad| cantidad }


puts "The peak registration time is at #{main_hour[0]} hours, with #{main_hour[1]} records."

end

def weekday_targeting(dates)
  daily_record = Hash.new(0)

dates.each do |date|
  clean_date = Date.strptime(date, "%m/%d/%y")
  weekday = clean_date.wday
  daily_record[weekday] += 1
end

main_day = daily_record.max_by { |day, amount| amount }

puts "The peak registration day is #{["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"][main_day[0]]}, with #{main_day[1]} records."

end

dates = []

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone_number = clean_phone_number(row[:homephone].to_s)
  legislators = legislators_by_zipcode(zipcode)

  dates << row[:regdate]
  form_letter = erb_template.result(binding)

  save_thank_you_letter(id,form_letter)
end

time_targeting(dates)
weekday_targeting(dates)
