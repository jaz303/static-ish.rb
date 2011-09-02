module StaticIsh
  module Pages
    class Blog < Base
      def find_child_page(url_cons)
        if url_cons =~ /^\d{4}\/\d{2}\/...$/
          
        else
          nil
        end
      end
      
      def posts(options = {})
        
      end
      
    private
      
      def post_paths
        unless defined?(@post_paths)
          @post_paths = Dir.glob("#{File.dirname(path)}/*/*/*.page").inject([]) do |ary, p|
            p = p.gsub(File.dirname(path) + '/', '')
            if p =~ /^\d{4}\/\d{1,2}\/\d{1,2}-([a-z0-9_-]+)\.page$/i
              chunks = p.split('/')
              chunks[1] = "0#{chunks[1]}" if chunks[1] =~ /^\d$/
              chunks[2] = "0#{chunks[2]}" if chunks[2] =~ /^\d-/
              p = chunks.join('/')
            end
            ary
          end
          @post_paths.sort!
          @post_paths.reverse!
        end
        @post_paths
      end
    end
  end
end