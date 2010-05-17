
module Qt

  class LineEdit

    def signals
      base_list = super
      base_list[:textChanged] = "textChanged(QString)"
      base_list[:textEdited] = "textEdited(QString)"
      return base_list
    end
  end
end