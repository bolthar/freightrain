
module Qt

  class AbstractButton

    def signals
      base_list = super
      base_list[:toggled] = "toggled(bool)"
    end

  end
end