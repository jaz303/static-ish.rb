require 'yaml'

module StaticIsh
  autoload :Site,                   'static_ish/site'
  
  autoload :Application,            'static_ish/application'              # Rack application
  
  autoload :ApplicationAware,       'static_ish/application_aware'        # Mixin for exposing site to other classes
  autoload :PageLoader,             'static_ish/page_loader'              # Loads/assembles pages from the filesystem
  autoload :Registry,               'static_ish/registry'                 # Directory of known page/part types
  
  module Pages
    autoload :Base,                 'static_ish/pages/base'               # Base page implementation
    autoload :Page,                 'static_ish/pages/page'               # Default page type
  end
  
  module Parts
    autoload :Base,                 'static_ish/parts/base'
    autoload :Code,                 'static_ish/parts/code'
    autoload :HTML,                 'static_ish/parts/html'
    autoload :Markdown,             'static_ish/parts/markdown'
    autoload :Textile,              'static_ish/parts/textile'
  end
  
end