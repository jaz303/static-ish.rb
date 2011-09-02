require 'erb'
require 'yaml'

module StaticIsh
  autoload :Site,                   'static_ish/site'
  
  autoload :Application,            'static_ish/application'              # Rack application
  
  autoload :ApplicationAware,       'static_ish/application_aware'        # Mixin for exposing site to other classes
  autoload :Registry,               'static_ish/registry'                 # Directory of known page/part types
  autoload :RenderingContext,       'static_ish/rendering_context'
  
  module Pages
    autoload :Base,                 'static_ish/pages/base'               # Base page implementation
    autoload :Blog,                 'static_ish/pages/blog'
    autoload :Page,                 'static_ish/pages/page'               # Default page type
    autoload :Post,                 'static_ish/pages/post'
  end
  
  module Parts
    autoload :Base,                 'static_ish/parts/base'
    autoload :Code,                 'static_ish/parts/code'
    autoload :HTML,                 'static_ish/parts/html'
    autoload :Markdown,             'static_ish/parts/markdown'
    autoload :Textile,              'static_ish/parts/textile'
  end
end