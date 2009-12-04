
module Freightrain

  module DialogExtension

    def show_dialog(*args)
      on_show(*args)
      @on_close = lambda { |*params| yield(*params) } if block_given?
      @view.update
      show
    end

    def on_show(*args)
      #to override
    end

    def close(*args)
      @on_close.call(*args) if @on_close
      hide
    end

    def cancel
      hide
    end

  end
end
