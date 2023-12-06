# frozen_string_literal: true

require './classes'
require './filereading'
require './date'
require './calculate_average'
require './calculate_temp'
# All the Methods for manipulation
module MyMethods
  include ClassWeather
  include Filereading
  include Date
  include Calculation
  include CalculateTemp
  def calculate
    calculate_max_temp
    calculate_min_temp
    calculate_humidity
  end

  def average
    highest_average_temp
    lowest_average_temp
    average_humidity
  end

  def color(month, year)
    puts "#{month} #{year}"
    @filesdata.each do |data_inner_array|
      split_data = data_inner_array[0].split(',')
      date_split = split_data[0].split('-')
      if !split_data[1].nil? && split_data[1].length <= 4 && !split_data[1].empty?
        print format('%.2i', "#{date_split[2]} ")
        split_data[1].to_i.times { print '+'.colorize(:red) }
        print " #{split_data[1]}C\n"
      end
      next unless !split_data[3].nil? && split_data[3].length <= 4 && !split_data[3].empty?

      print format('%.2i', "#{date_split[2]} ")
      split_data[3].to_i.times { print '+'.colorize(:blue) }
      print " #{split_data[3]}C\n"
    end
  end

  def split_array; end

  def color_low_high
    @filesdata.each do |data_inner_array|
      split_data = data_inner_array[0].split(',')
      date_split = split_data[0].split('-')
      next unless !split_data[1].nil? && split_data[1].length <= 4 || !split_data[3].nil? && split_data[3].length <= 4

      print format('%.2i', "#{date_split[2]} ")
      split_data[3].to_i.times { print '+'.colorize(:blue) }
      split_data[1].to_i.times { print '+'.colorize(:red) }
      print "#{split_data[3]}C-#{split_data[1]}C\n"
    end
  end
end
