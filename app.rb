class App

  require_relative 'Format'

  def call(env)
    request   = Rack::Request.new(env)
    formatter = Format.new(request)
    formatter.formatted_time
  end
end