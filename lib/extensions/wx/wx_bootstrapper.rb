
require 'wx'

require File.join(File.dirname(__FILE__), "interface_builder.rb")
require File.join(File.dirname(__FILE__), "dialog_helper.rb")
require File.join(File.dirname(__FILE__), "widgets", "wx_sizer.rb")

module Freightrain

  module Toolkit

    class WxApp < Wx::App

      def initialize(&block)
        super
        @startup = block
      end

      def on_init
        @startup.call
      end

    end

    def self.start_main_loop
      app = WxApp.new do
        yield
      end
      app.main_loop
    end

  end

end