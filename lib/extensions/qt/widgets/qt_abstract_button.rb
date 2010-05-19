
module Qt

  class AbstractButton

    def signals
      base_list = super
      base_list[:toggled] = "toggled(bool)"
      return base_list
    end

  end
end