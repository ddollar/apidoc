# API Documentation Generator

Allows you to add inline documentation to a Sinatra app and have a web-based
documentation browser be available to you.

## Documentation Format

    # Create an application.
    #
    # @param <name>  the name of the application to create
    # @param [stack] the stack on which to create the application
    #
    # @request
    #   POST /apps.json
    #   name=example&stack=bamboo-ree-1.8.7
    # @response
    #   {
    #     "id":         1,
    #     "name":       "example",
    #     "owner":      "user@example.org",
    #     "created_at": "Sat Jan 01 00:00:00 UTC 2000",
    #     "stack":      "bamboo-ree-1.8.7",
    #     "slug_size":  1000000,
    #     "repo_size":  500000,
    #     "dynos":      1,
    #     "workers":    0
    #   }

    post "/apps.json" do
      # do something here
    end

## Web-based browser

    map "/docs" do
      run Sinatra::APIDocs::Viewer.new(Dir["lib/**/*.rb"])
    end
