# frozen_string_literal: true

# For pick month
module Date
  # date changing integer to Litrature
  class DateMonths
    def initialize
      @months = { 1 => 'Jan', 2 => 'Feb', 3 => 'Mar', 4 => 'Apr', 5 => 'May', 6 => 'Jun',
                  7 => 'Jul', 8 => 'Aug', 9 => 'Sep', 10 => 'Oct', 11 => 'Nov', 12 => 'Dec' }
    end
  end
end
