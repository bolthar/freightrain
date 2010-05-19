
module Qt

  class CalendarWidget

    def signals
      base_list = super
      base_list[:clicked] = "clicked(QDate)"
      base_list[:activated] = "activated(QDate)"
      return base_list
    end

    def selectedDate=(value)
      if value.kind_of? ::Date
        super(value)
      end
    end

  end

end