# frozen_string_literal: true

require './file_reading'
require './date/month'
require './average_calculation'

# All the Methods for manipulation
module TemperatureCalculation
  include FileReading
  include Date
  include AverageCalculation

  def calculate_max_temperature
    calculate_temperature(1, :>, -999, 'Highest')
  end

  def calculate_min_temperature
    calculate_temperature(3, :<, 999, 'Lowest')
  end

  def calculate_humidity
    calculate_temperature(7, :>, -999, 'Humidity') { |value| "#{value}%" }
  end

  private

  def calculate_temperature(value_index, comparison_operator, default_value, label)
    @result_value = default_value
    @result_month = @result_day = 0

    process_data_for_calculated_temperature(value_index, comparison_operator)
    return unless @result_value != default_value

    formatted_value = label == 'Humidity' ? "#{@result_value}%" : "#{@result_value}°C"
    puts "#{label}: #{formatted_value} on #{@result_month} #{@result_day}"
  end

  def process_data_for_calculated_temperature(value_index, comparison_operator)
    months = Month.new.instance_variable_get(:@months)
    update_values = false

    @weather_records.each do |data_inner_array|
      update_values |= process_data(data_inner_array[0], value_index, comparison_operator, months)
    end

    return unless update_values
  end

  def process_data(data, value_index, comparison_operator, months)
    split_data = data.split(',')
    date_split = split_data[0].split('-')

    return false unless valid_data?(split_data[value_index])

    current_value = split_data[value_index].to_i

    return false unless current_value.to_s.length <= 4 && current_value.send(comparison_operator, @result_value)

    @result_value = current_value
    @result_month = months[date_split[1].to_i]
    @result_day = date_split[2].to_i
    true
  end

  def valid_data?(data)
    !data.nil?
  end
end
