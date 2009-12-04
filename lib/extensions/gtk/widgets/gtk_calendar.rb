

module Gtk

  class Calendar

    def date
      return DateTime.civil(year, month+1, day)
    end

    def date=(val)
      day   = val.day
      month = val.month
      year  = val.year
    end
    
  end
end

