module StaticIsh
  module ApplicationAware
    def site
      @site
    end
    
    def registry
      @site.registry
    end
  end
end