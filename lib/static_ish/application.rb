module StaticIsh
  class Application
    attr_reader :registry
    
    def initialize
      @registry = Registry.new
    end
    
    def create_page_loader
      PageLoader.new(self)
    end
    
  end
end