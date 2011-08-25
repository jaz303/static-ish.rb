module StaticIsh
  class Registry
    include ApplicationAware
    
    def initialize(site)
      @site = site
      
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
      klass.type = name if klass.is_a?(Class)
      nil
    end
    
    def page_class(type)
      klass = @page_types[type.to_sym]
      klass = eval(klass) if klass.is_a?(String)
      klass
    end
    
    def page_type(page_class)
      reverse_page_types[page_class.is_a?(Class) ? page_class : page_class.class]
    end

    def build_part(type, source = '', options = {})
      klass = @part_types[type.to_sym]
      if klass.is_a?(String)
        klass = eval(klass)
        klass.type = type
        @part_types[type.to_sym] = klass
      end
      klass.new(source, options)
    end
    
  private
    def reverse_page_types
      @reverse_page_types ||= @page_types.inject({}) { |h,(k,v)| h[v.is_a?(String) ? eval(v) : v] = k; h }
    end
  
  end
end