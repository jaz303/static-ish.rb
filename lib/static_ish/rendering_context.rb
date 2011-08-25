module StaticIsh
  class RenderingContext
    def site; @__site; end
    def page; @__page; end
    def parts; page.parts; end
    
    def initialize(site, page)
      @__site, @__page = site, page
    end
    
    def h(html)
      ::CGI.escapeHTML(html)
    end
    
    def content_for_layout
      @content_for_layout || ''
    end
    
    def __render
      @content_for_layout = __render_erb(__page_template_path)
      __render_erb(__layout_template_path)
    end
    
  private
    
    def __render_erb(path)
      ERB.new(File.read(path)).result(binding)
    end
    
    def __layout_template_dir
      @__layout_template_dir ||= File.join(site.view_root, 'layouts', page.layout)
    end
    
    def __layout_template_path
      @__layout_template_path ||= File.join(__layout_template_dir, 'layout.html.erb')
    end
    
    def __page_template_path
      unless defined?(@__page_template_path)
        @__page_template_path = [
          File.join(__layout_template_dir, 'pages', page.type.to_s, 'page.html.erb'),
          File.join(site.view_root, 'pages', page.type.to_s, 'page.html.erb')
        ].detect { |t| File.exists?(t) }
      end
      @__page_template_path
    end
  end
end