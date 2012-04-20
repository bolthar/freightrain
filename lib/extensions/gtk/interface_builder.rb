require 'rexml/document'

module Freightrain

  module Toolkit

    class InterfaceBuilder

      def initialize
        @builder = Gtk::Builder.new
      end

      def file_found?(file_name)
        return get_glade_file(file_name)
      end

      def create_objects_from_file(file_name)
        file = get_glade_file(file_name)
        corrected_xml = replace_faulty_gtkboxes(File.read(file))
        @builder.add_from_string(corrected_xml)
        objects = @builder.objects        
        if objects.first.respond_to? :toplevel
          @control = objects.first.toplevel
        end
        return objects.select do |obj|
          obj.respond_to? :name
        end
      end

      def create_object_accessors(widgets, view)
        widgets.select { |widget| widget.respond_to? :name }.each do |widget|
          name = widget.name
          view.instance_eval "def #{name}; @widgets.select { |w| w.name == '#{name}'  }.first ;end;"
        end
      end

      def connect_to_callback(widget, event_name, method)
        begin
        widget.signal_connect(event_name) do |instance, *args|
          arguments = [instance, *args].first(method.arity.abs)
          method.call(*arguments)
        end
        rescue Exception => ex
          #TODO:handle this
        end
      end

      def get_glade_file(file_name)
        search_path = File.join(
          Freightrain.app_path,
          "views",
          "**",
          file_name.to_convention + ".glade")
        results = Dir.glob(search_path)
        return results.first
      end
      
      def replace_faulty_gtkboxes(xml)
        document = REXML::Document.new(xml)
        document.elements.each("//object[@class='GtkBox']") do |box|
          substitute_class = "GtkHBox"
          box.elements.each("property[@name='orientation']") do |orientation|
            substitute_class = orientation == "vertical" ? "GtkVBox" : "GtkHBox"
          end
          p "here3"
          box.attributes["class"] = substitute_class
        end
        return document.to_s
      end

      def control
        return @control
      end

    end

  end
end
