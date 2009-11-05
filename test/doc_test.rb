require File.join(File.dirname(__FILE__), *%w(test_helper))

class DocTest < Test::Unit::TestCase
  class A < Sinatra::Base
    register Sinatra::Doc

    doc "gets a list of materia"
    get "/materia" do
      "..."
    end
    
    get "/undocumented" do
      "..."
    end
    
    doc "gets a specific materia", { 
      :kind => "color of the materia [red,green,blue,yellow,purple]"
    }
    get "/materia/:kind" do
      "..."
    end
  end
  
  class B < Sinatra::Base
    register Sinatra::Doc do
      def title
        "Beez Kneez"
      end
    end

    doc "get a list of bees"
    get "/bees" do
      "..."
    end
  end
  
  def documented_app
    A
  end
  
  def documented_app_with_overrides
    B
  end
  
  context 'a documented sinatra app' do
    should 'have a documented api' do
      browser = Rack::Test::Session.new(
        Rack::MockSession.new(documented_app)
      )
      browser.get '/doc'
      assert browser.last_response.ok?
      [
        "GET /materia",
        "gets a list of materia",
        "/materia/:kind",
        "gets a specific materia",
        "color of the materia [red,green,blue,yellow,purple]"
      ].each { |phrase|
        assert browser.last_response.body.include?(phrase)
      }
  
      assert !browser.last_response.body.include?("/undocumented")
    end
    
    context "with doc overrides" do
      should "render with overrides" do
        browser = Rack::Test::Session.new(
          Rack::MockSession.new(documented_app_with_overrides)
        )
        browser.get '/doc'
        assert browser.last_response.ok?
        [
          "Beez Kneez",
          "GET /bees",
          "get a list of bees"
        ].each { |phrase|
          assert browser.last_response.body.include?(phrase)
        }
      end
    end
  end
end