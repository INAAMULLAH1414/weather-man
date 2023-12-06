# frozen_string_literal: true

require 'colorize'
require './classes'
require './filereading'
require './weather_methods'
require './date'

begin
  include MyMethods
  include Date

  args = ARGV
  if args.empty? || args.length != 3
    puts 'Wrong Argument'
    exit 0
  end

  path = ''
  weather = Weather.new

  if args[0] == '-e'
    path = (args[2]).to_s
    puts 'Wrong Argument' if args[1].length != 4
    if args[1].length == 4
      file_name = (args[1]).to_s
      weather.reading(path, file_name)
      weather.calculate
    end
  end

  if (args[0] == '-a') || (args[0] == '-c')

    months = DateMonths.new.instance_variable_get(:@months)
    year_month = args[1].split '/'
    integer_month = year_month[1].to_i
    raise 'Wrong Year'  if  year_month[0] == '' || year_month[0].length != 4
    raise 'Wrong Month' if  integer_month.zero? || integer_month > 12

    month = months[integer_month]
    path = (args[2]).to_s
    file_name = "#{year_month[0]}_#{month}"
    weather.reading(path, file_name)

    weather.average if args[0] == '-a'
    if year_month[1].length == 2 && args[0] == '-c'
      weather.color(month,
                    year_month[0])
    end
    if year_month[1].length == 1 && args[0] == '-c'
      puts "#{month} #{year_month[0]}"
      weather.color_low_high
    end
  end
rescue StandardError => e
  puts e
end
