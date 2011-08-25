module StaticIsh
  class Registry
    def initialize
      @page_types = {
        :page             => '::StaticIsh::Pages::Page'
      }
    
      @part_types = {
        :code             => '::StaticIsh::Parts::Code',
        :html             => '::StaticIsh::Parts::HTML',
        :markdown         => '::StaticIsh::Parts::Markdown',
        :textile          => '::StaticIsh::Parts::Textile'
      }
    end
    
    def register_page(name, klass)
      @page_types[name.to_sym] = klass
    end
    
    def register_part(name, klass)
      @part_types[name.to_sym] = klass
    end
    
    def build_page(path, type, preamble = {}, parts = [])
      klass = @page_types[type.to_sym]
      klass = eval(klass) if klass.is_a?(String)
      klass.new(path, preamble, parts)
    end
    
    def build_part(type, source = '', options = {})
      klass = @part_types[type.to_sym]
      klass = eval(klass) if klass.is_a?(String)
      klass.new(source, options)
    end
  end
end