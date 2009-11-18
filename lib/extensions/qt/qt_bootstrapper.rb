

module Freightrain

  module Toolkit

    def self.start_main_loop
      Qt::Application.new([]).exec
    end
  end

end