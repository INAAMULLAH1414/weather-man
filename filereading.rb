# frozen_string_literal: true

require './classes'

# For File reading
module Filereading
  include ClassWeather

  def reading(path, files)
    Dir.each_child(path) do |filenames|
      @filesarray << "./#{path}/#{filenames}" if filenames.include? files
    end
    raise 'File not Found' if @filesarray == []

    @filesarray.each do |filename|
      File.readlines(filename).each { |lines| @filesdata << lines.chomp.split('\n') }
    end
    @filesdata
  rescue StandardError
    raise 'Directory not found'
  end
end
