
require 'pry'

class Application

    @@items = [Item.new("Figs",3.42)]

    def call(env)
        resp = Rack::Response.new(env)
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            
            item = req.path.split("/items/").last
            
            item_found = @@items.select {|i| i.name == item}
            if item_found.size > 0
                resp.write item_found[0].price
                resp.status = 200 
            else
                resp.write "Item not found"
                resp.status = 400
            end
        else
            resp.write "Route not found"
            resp.status = 404
        end
        resp.finish
    end
end