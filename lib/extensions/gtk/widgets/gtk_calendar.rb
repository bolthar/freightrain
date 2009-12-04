
module Gtk

  class Calendar

    def date
      return DateTime.civil(self.year, self.month + 1, self.day)      
    end

    def date=(val)
      self.day   = val.day
      self.month = val.month - 1
      self.year  = val.year
    end
    
  end
end

