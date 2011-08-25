module StaticIsh
  class Site
    attr_reader :root             # root dir of site
    attr_reader :public_root      # root of public content (pages, assets)
    attr_reader :view_root        # root for views
    attr_reader :registry         # registry of page/parts
    attr_reader :home             # home page
    
    def [](path)
      home
    end
    
    def initialize(root)
      @root         = File.expand_path(root)
      @public_root  = File.join(@root, 'public')
      @view_root    = File.join(@root, 'views')
      @registry     = Registry.new(self)
      @home         = nil
    end
    
    def home
      @home ||= load_page(File.join(public_root, 'index.page'))
    end
    
    def reload!
      @home = nil
    end

  private
    DEFAULT_PREAMBLE = {'layout' => 'main', 'type' => 'page'}
  
    def load_page(path)
      @parts, @part, @preamble, @buffer = [], nil, DEFAULT_PREAMBLE.dup, ''
      
      File.open(path).each_line do |line|
        if line =~ /^--- ([\w-]+)\s*([^$]+)?$/
          commit_part!
          @part, @buffer = {:name => $1, :options => $2.to_s.strip}, ''
        else
          @buffer << line
        end
      end
      
      commit_part!
      
      page_klass = registry.page_class(@preamble['type'])
      page = page_klass.new(self, path, @preamble, @parts)
      page
    end
    
    def commit_part!
      if @part.nil?
        @buffer.strip!
        @preamble.update(YAML.load(@buffer)) if @buffer.length > 0
      else
        @parts << registry.build_part(@part[:name], @buffer, YAML.load('{' + @part[:options] + '}'))
      end
    end
  end
end