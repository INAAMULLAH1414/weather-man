# frozen_string_literal: true

require './classes'
require './filereading'
require './date'
require './calculate_average'

# All the Methods for manipulation
module CalculateTemp
  include ClassWeather
  include Filereading
  include Date
  include Calculation

  def calculate_max_temp
    highest_temprature = -999
    highest_temprature_month = highest_temprature_day = 0
    months = DateMonths.new.instance_variable_get(:@months)
    @filesdata.each do |data_inner_array|
      split_data = data_inner_array[0].split(',')
      date_split = split_data[0].split('-')

      next unless !split_data[1].nil? && split_data[1].length <= 4 && (split_data[1].to_i > highest_temprature)

      highest_temprature = split_data[1].to_i
      highest_temprature_month = months[date_split[1].to_i]
      highest_temprature_day = date_split[2].to_i
    end
    if highest_temprature != 999
      puts "Highest: #{highest_temprature}C on #{highest_temprature_month} #{highest_temprature_day}"
    end
  end

  def calculate_min_temp
    lowest_temprature = 999
    lowest_temprature_month = lowest_temprature_day = 0
    months = DateMonths.new.instance_variable_get(:@months)
    @filesdata.each do |data_inner_array|
      split_data = data_inner_array[0].split(',')
      date_split = split_data[0].split('-')
      next unless !split_data[3].nil? && split_data[3].length <= 4 && (split_data[3].to_i < lowest_temprature)

      lowest_temprature = split_data[3].to_i
      lowest_temprature_month = months[date_split[1].to_i]
      lowest_temprature_day = date_split[2].to_i
    end
    if lowest_temprature != 999
      puts "Lowest: #{lowest_temprature}C on #{lowest_temprature_month} #{lowest_temprature_day}"
    end
  end

  def calculate_humidity
    humidity = -999
    humidity_month = humidity_day = 0
    months = DateMonths.new.instance_variable_get(:@months)
    @filesdata.each do |data_inner_array|
      split_data = data_inner_array[0].split(',')
      date_split = split_data[0].split('-')
      next unless !split_data[7].nil? && split_data[7].length <= 4 && !split_data[7].empty?
      next unless split_data[7].to_i > humidity

      humidity = split_data[7].to_i
      humidity_month = months[date_split[1].to_i]
      humidity_day = date_split[2].to_i
    end
    puts "Humidity: #{humidity}% on #{humidity_month} #{humidity_day}" if humidity != -999
  end
end
