class MyApp

  require_relative 'Format'

  def call(env)
    controller(env)
  end


  private

  def controller(env)
    request = Rack::Request.new(env)
    if validation(request)
      ft = Format.new(parse_url(request))
      if ft.errors.empty?
        t = Time.now
        response(200, [t.strftime(ft.time_string.chop!)])
      else
        response(400, ["Unknown time format #{ft.errors}"])
      end
    else
      response(404, ["Unknown time format #{request.path_info}"])
    end
  end

  def validation(request)
    request.path_info == '/time'
  end

  def response(status, body)
    response = Rack::Response.new(body, status)
    response.add_header 'Content-Type', 'text/plain'
    response
  end

  def parse_url(request)
    request.params["format"].split(',')
  end

end