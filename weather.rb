# frozen_string_literal: true

require 'colorize'
require './classes/weather'
require './file_reading'
require './helper_methods'
require './date/month'

begin
  include HelperMethods
  include Date

  console_arguments = ARGV
  if console_arguments.empty? || console_arguments.length != 3
    puts 'Wrong Argument'
    exit 0
  end

  path = ''
  weather = Weather.new

  if console_arguments[0] == '-e'
    path = (console_arguments[2]).to_s
    puts 'Wrong Argument' if console_arguments[1].length != 4
    if console_arguments[1].length == 4
      file_name = (console_arguments[1]).to_s
      weather.reading(path, file_name)
      weather.calculate
    end
  end

  if (console_arguments[0] == '-a') || (console_arguments[0] == '-c')

    months = Month.new.instance_variable_get(:@months)
    year_month = console_arguments[1].split '/'
    integer_month = year_month[1].to_i
    raise 'Wrong Year'  if  year_month[0] == '' || year_month[0].length != 4
    raise 'Wrong Month' if  integer_month.zero? || integer_month > 12

    month = months[integer_month]
    path = (console_arguments[2]).to_s
    file_name = "#{year_month[0]}_#{month}"
    weather.reading(path, file_name)

    weather.average if console_arguments[0] == '-a'
    if year_month[1].length == 2 && console_arguments[0] == '-c'
      weather.two_horizontal_bar_charts(month, year_month[0])
    end
    if year_month[1].length == 1 && console_arguments[0] == '-c'
      puts "#{month} #{year_month[0]}"
      weather.single_bar_chart
    end
  end
rescue StandardError => e
  puts e
end
