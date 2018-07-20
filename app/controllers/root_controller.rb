class RootController < ApplicationController
  get '/' do
    response = {
      success: true,
      message: "hello, world",
    }.to_json

    content_type :json
    status 200
    body response
  end
end
