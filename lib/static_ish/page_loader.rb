module StaticIsh
  class PageLoader
    include ApplicationAware
    
    def initialize(app)
      @app = app
    end
    
    def load(path)
      @parts, @part, @preamble, @buffer = [], nil, {'type' => 'page'}, ''
      
      File.open(path).each_line do |line|
        if line =~ /^--- ([\w-]+)\s*([^$]+)?$/
          commit_part!
          @part, @buffer = {:name => $1, :options => $2.to_s.strip}, ''
        else
          @buffer << line
        end
      end
      
      commit_part!
      registry.build_page(path, @preamble['type'], @preamble, @parts)
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