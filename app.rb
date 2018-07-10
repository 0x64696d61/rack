class App
  require 'rack'
  require_relative 'Format'

  def call(env)
    request   = Rack::Request.new(env)
    @response = Rack::Response.new([], 404, { 'Content-Type' => 'text/plain' })

    if request.path_info == '/time'
      time_response(request.params)
    else
      @response.write "Unknown time format #{request.path_info}"
      @response.status = 404
    end
    @response.finish
  end

  def time_response(params)
    formatter = Format.new(params)
    if formatter.result
      @response.write formatter.result
      @response.status = 200
    else
      @response.write "Unknown time format #{formatter.errors}"
      @response.status = 400
    end
  end

end
