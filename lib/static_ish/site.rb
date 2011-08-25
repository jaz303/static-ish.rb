module StaticIsh
  class Site
    attr_reader :root
    attr_reader :registry
    
    def initialize(root)
      @root = File.expand_path(root)
      @registry = Registry.new
    end
    
    def create_page_loader
      PageLoader.new(self)
    end
  end
end