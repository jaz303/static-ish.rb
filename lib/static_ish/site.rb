module StaticIsh
  class Site
    attr_reader :root
    attr_reader :public_root
    attr_reader :registry
    
    def [](path)
      nil
    end
    
    def initialize(root)
      @root = File.expand_path(root)
      @public_root = File.join(@root, 'public')
      @registry = Registry.new
    end
    
    def create_page_loader
      PageLoader.new(self)
    end
  end
end