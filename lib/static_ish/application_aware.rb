module StaticIsh
  module ApplicationAware
    def registry
      @app.registry
    end
  end
end