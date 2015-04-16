
class Device
  module Classes
    def android?
      self.is?("Generic Android")
    end

    def ios?
      self.is?("Apple iPod, iPhone or iPad")
    end

    def windows?
      self.is?("Windows")
    end

    def mac?
      self.is?("Macintosh")
    end

    def windows_phone?
      self.is?("Windows Phone")
    end

    def blackberry?
      self.is?("RIM BlackBerry")
    end
  end
end
