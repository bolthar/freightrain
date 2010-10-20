
class LoggerView < FreightView

  signal :quit, :forwards => "logger_window.destroy"
  signal :run, :forwards => "execute.clicked"

end