# frozen_string_literal: true

require './file_reading'
require './date/month'
require './average_calculation'
require './temperature_calculation'

# All the Methods for manipulation
module HelperMethods
  include FileReading
  include Date
  include AverageCalculation
  include TemperatureCalculation

  def calculate
    calculate_max_temperature
    calculate_min_temperature
    calculate_humidity
  end

  def average
    highest_average_temperature
    lowest_average_temperature
    average_humidity
  end

  def two_horizontal_bar_charts(month, year)
    puts "#{month} #{year}"
    @weather_records.each do |data_inner_array|
      draw_two_bar_charts(data_inner_array[0])
    end
  end

  def single_bar_chart
    @weather_records.each do |data_inner_array|
      split_data = data_inner_array[0].split(',')
      date_split = split_data[0].split('-')

      next unless valid_data?(split_data[1]) || valid_data?(split_data[3])

      draw_bar_chart(date_split, split_data)
    end
  end

  private

  def valid_data?(data)
    !data.nil? && data.length <= 4
  end

  def draw_bar_chart(date_split, split_data)
    print format('%.2i', "#{date_split[2]} ")

    display_color(:blue, split_data[3].to_i)
    display_color(:red, split_data[1].to_i)

    puts "#{split_data[3]}°C-#{split_data[1]}°C"
  end

  def display_color(color, times)
    times.times { print '+'.colorize(color) }
  end

  def draw_two_bar_charts(data)
    split_data = data.split(',')
    date_split = split_data[0].split('-')

    temprature_on_bar_chart(:red, date_split[2], split_data[1]) if valid_data?(split_data[1])
    temprature_on_bar_chart(:blue, date_split[2], split_data[3]) if valid_data?(split_data[3])
  end

  def temprature_on_bar_chart(color, day, temperature_data)
    return unless temperature_data.length <= 4 && !temperature_data.empty?

    print format('%.2i', "#{day} ")
    temperature_data.to_i.times { print '+'.colorize(color) }
    puts " #{temperature_data}°C"
  end
end
