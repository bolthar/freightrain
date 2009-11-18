
module Freightrain

  def load_extensions!()
    require_all File.dirname(__FILE__) + "/../extensions/#{@toolkit.to_s}"
  end

  def start_toolkit_mainloop!(viewmodel_name)
    @toolkit ||= :gtk
    Freightrain[(viewmodel_name.to_s + "_view_model").to_sym].show
    p Toolkit
    Toolkit.start_main_loop
  end
  
end
