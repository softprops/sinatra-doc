module Sinatra
  # executable api documentation
  module Doc
    class Route
      attr_accessor :desc, :params, :paths
      
      def initialize(attrs={})
        attrs.each_pair { |k,v| send "#{k}=",v if respond_to? "#{k}=" }
        self.paths = []
      end
      
      def <<(path)
        self.paths << path
      end
      
      def to_s
        self.inspect
      end
      
      def inspect
        "#{@paths.join(', ')} # #{@desc}"
      end
    end
    
    def self.registered(app)
      app.get '/doc' do
        app.instance_eval { render_docs_page(@docs) }
      end      
    end
    
    def doc(desc, params = {})
      @last_doc = Route.new(:desc => desc, :params => params)
      (@docs ||= []) << @last_doc
    end
    
    def title
      "sinatra doc"
    end
    
    def header
      "<h1>%s</h1>" % title
    end
    
    def method_added(method)
      return if method.to_s =~ /(^(GET|HEAD) \/doc\z)/
      if method.to_s =~ /(GET|POST|PUT|DELETE|UPDATE|HEAD)/ && @last_doc
        @last_doc << method
        @last_doc = nil
      end
      super
    end
    
    def render_docs_list(routes) 
      routes.inject('<dl>') { |markup, route|
        path = route.paths.join(', ')
        desc = route.desc
        params = route.params.inject('') { |li,(k,v)|
          li << "<dt>:%s</dt><dd>%s</dd>" % [k,v]
        }
        markup << "<dt>%s</dt><dd>%s<dl>%s</dl></dd>" % [path, desc, params]
      } << "</dl>"
    end
    
    def render_docs_page(routes)
      (<<-HTML)
        <html>
          <head><title>#{title}</title></head>
          <style type="text/css">
            #container{width:960px; margin:1em auto; font-family:monaco, monospace;}
            dt{ background:#f5f5f5; font-weight:bold; float:left; margin-right:1em; }
            dd{ margin-left:1em; }
          </style>
          <body>
            <div id="container">
              #{header}
              #{render_docs_list(routes)}
            </div>
          </body>
        </html>
      HTML
    end
  end
end