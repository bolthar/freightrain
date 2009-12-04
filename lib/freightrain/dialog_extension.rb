
module Freightrain

  module DialogExtension

    def show_dialog(*args)
      on_show(*args)
      show
    end

    def on_close=(proc)
      @on_close = proc
    end

    def close(*args)
      @on_close.call(*args)
    end

  end
end
