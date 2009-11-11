
module Qt

  class Base

    def name
      return objectName if self.respond_to? :objectName
    end

  end

end