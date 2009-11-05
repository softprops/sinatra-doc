require 'sinatra/base'
require File.join(File.dirname(__FILE__), *%w(lib doc))

# a reference usage of Sinatra::Doc
module Kittens
  class App < Sinatra::Base
    register Sinatra::Doc do
      def title 
       "kittenz api"
      end
      
      def header
        (<<-HEADER)
        <h1>
         <pre>
           kittenz
               _                        
               \`*-.                    
                )  _`-.                 
               .  : `. .                
               : _   '  \               
               ; *` _.   `*-._          
               `-.-'          `-.       
                 ;       `       `.     
                 :.       .        \    
                 . \  .   :   .-'   .   
                 '  `+.;  ;  '      :   
                 :  '  |    ;       ;-. 
                 ; '   : :`-:     _.`* ;
              .*' /  .*' ; .*`- +'  `*' 
              `*-*   `*-*  `*-*'
          </pre>
        </h1>
        HEADER
      end
    end
    
    doc 'lists all kittens'
    get '/kittens' do
      '...'
    end
    
    doc 'gets a kitten by name', {
      :name => "name of kitten"
    }
    get '/kittens/:name' do |name|
      "..."
    end
    
    doc 'creates a new kitten'
    post '/kittens' do
      '...'
    end
    
    doc 'updates a kitten', {
      :name => 'name of kitten'
    }
    put "/kittens/:id" do
      '...'
    end
    
    doc 'deletes a given kitten', {
      :name => 'name of kitten'
    }
    delete '/kittens/:name' do |name|
      '...'
    end
    
  end
end