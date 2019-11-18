class Application
    @@items = [Item.new("Apples",5.23), Item.new("Oranges",2.43)] # We need to create items to work with and display.

    def call(env)
        resp= Rack::Response.new # Create a new rack that can serve responses
        req= Rack::Request.new(env) # Create the rack with a way to dynamically filter requests.

    if req.path.match(/items/) # If the request path in the URL matches /items/ do:
        item= req.path.split("/items/").last # turn /items/Apple into Apple and set it equal to item
        if item =@@items.find{|i| i.name == item} # If item exists in @@items, return the price to the browser
        resp.write item.price
    else #otherwise return a 400 error and a browser error
        resp.status= 400
        resp.write "Item not found!"
    end
    else # If the request URL does not match /items/ return 404 and a browser error
    resp.status=404
    resp.write "Route not found"
    end
    resp.finish
end
end
