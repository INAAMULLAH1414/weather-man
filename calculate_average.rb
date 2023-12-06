# frozen_string_literal: true

require './classes'
require './filereading'
require './date'

# All the Methods for manipulation
module Calculation
  include ClassWeather
  include Filereading
  include Date

  def highest_average_temp
    highest_sum = highest_count = 0
    @filesdata.each do |data_inner_array|
      split_data = data_inner_array[0].split(',')
      if !split_data[1].nil? && split_data[1].length <= 4 && !split_data[1].empty?
        highest_sum += split_data[1].to_i
        highest_count += 1
      end
    end
    puts "Highest Average: #{(highest_sum / highest_count).to_i}C" if highest_count != 0
  end

  def lowest_average_temp
    lowest_sum = lowest_count = 0
    @filesdata.each do |data_inner_array|
      split_data = data_inner_array[0].split(',')
      if !split_data[3].nil? && split_data[3].length <= 4 && !split_data[3].empty?
        lowest_sum += split_data[3].to_i
        lowest_count += 1
      end
    end

    puts "Lowest Average:  #{(lowest_sum / lowest_count).to_i}C" if lowest_count != 0
  end

  def average_humidity
    humidity_sum = humidity_count = 0
    @filesdata.each do |data_inner_array|
      split_data = data_inner_array[0].split(',')
      if !split_data[7].nil? && split_data[7].length <= 4 && !split_data[7].empty?
        humidity_sum += split_data[7].to_i
        humidity_count += 1
      end
    end
    puts "Average Humidity: #{(humidity_sum / humidity_count).to_i}%" if humidity_count != 0
  end
end
