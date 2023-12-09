# frozen_string_literal: true

require './classes/weather'
require './file_reading'
require './date/month'

# All the Methods for manipulation
module AverageCalculation
  include ClassWeather
  include FileReading
  include Date

  def highest_average_temperature
    sum, count = calculate_average_temperature(1)

    display_average_temperature(sum, count, 'Highest')
  end

  def lowest_average_temperature
    sum, count = calculate_average_temperature(3)

    display_average_temperature(sum, count, 'Lowest')
  end

  def average_humidity
    sum, count = calculate_average_temperature(7)

    display_average_temperature(sum, count, 'Average Humidity', '%')
  end

  private

  def calculate_average_temperature(column)
    sum = count = 0

    @weather_records.each do |data_inner_array|
      split_data = data_inner_array[0].split(',')
      value = split_data[column]

      next unless valid_value?(value)

      sum += value.to_i
      count += 1
    end

    [sum, count]
  end

  def valid_value?(value)
    !value.nil? && value.length <= 4 && !value.empty?
  end

  def display_average_temperature(sum, count, label, unit = 'C')
    return unless count != 0

    average_value = (sum / count).to_i
    puts "#{label} Average: #{average_value}#{unit}"
  end
end
