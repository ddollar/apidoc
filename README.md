# Sinatra API Docs

Allows you to add inline documentation to a Sinatra app and have a web-based
documentation browser be available to you.

## Documentation Format

    register Sinatra::APIDocs

    section  "Applications"

    desc     "Create an application."
    param    "name",  "the name of the application to create"
    param    "stack", "[OPTIONAL] the stack on which to create the application"

    request  <<-REQUEST
      POST /apps.json"
      name=example&stack=bamboo-ree-1.8.7
    REQUEST

    response <<-RESPONSE
      {
        "id":         1,
        "name":       "example",
        "owner":      "user@example.org",
        "created_at": "Sat Jan 01 00:00:00 UTC 2000",
        "stack":      "bamboo-ree-1.8.7",
        "slug_size":  1000000,
        "repo_size":  500000,
        "dynos":      1,
        "workers":    0
      }
    RESPONSE

    post "/apps.json" do
      ...
    end

## Web-based browser

    map "/docs" do
      run Sinatra::APIDocs::Viewer.new(YourSinatraApp)
    end
    