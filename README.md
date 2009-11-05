# sinatra-doc

self documentaion for your [sinatra]("http://sinatrarb.com") app's routes

# usage

see the reference implementation [app.rb](http://github.com/softprops/sinatra-doc/blob/master/app.rb)
  
    > your app.rb
    
    class App < Sinatra::Base
      register Sinatra::Doc
      
      doc "gets a list of foos"
      get "foos" { ... }
    
      doc "gets a specific foo", { 
        :id => "identifier for a given foo"
      }
      get "foos/:id" { ... }
    end
    
    > GET /doc
    
    sinatra doc
    
    GET foos gets a list of foos
    
    GET foos/:id gets a specific foo
      :id identifier for a given foo
    
# Props

based on an idea [@bmizerany]("http://twitter.com/bmizerany") proposed in a [heroku]("http://heroku.com/") talk in nyc

# TODO

  * rake sinatra::doc #=> à la rails rake:routes 
  * clean up rendering of docs

2009 softprops (doug tangren)