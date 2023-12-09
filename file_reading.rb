# frozen_string_literal: true

# For File reading
module FileReading
  def reading(path, files)
    Dir.each_child(path) do |filenames|
      @files << "./#{path}/#{filenames}" if filenames.include? files
    end
    raise 'File not Found' if @files == []

    @files.each do |filename|
      File.readlines(filename).each { |lines| @weather_records << lines.chomp.split('\n') }
    end
    @weather_records
  rescue StandardError
    raise 'Directory not found'
  end
end
