class App
  require_relative 'rack_request'

  def initialize
    @result = RackRequest.new
    @errors = []
  end

  def call(env)
    time(env)
    [@result.status, @result.header, @result.body]
  end

  private

  def time(env)
    @result.default
    @errors.clear
    if env['PATH_INFO'].to_s == '/time'
      time_string = ''
      Rack::Utils.parse_nested_query(env['QUERY_STRING'])['format'].split(',').each do |x|
        time_string << map_date(x.to_sym).to_s << '-'
      end
      if @result.valid?
        t            = Time.now
        @result.body = [t.strftime(time_string.chop!)]
      else
        @result.body = ["Unknown time format #{@errors}"]
      end
    else
      @result.body   = ["Unknown time format [#{env['PATH_INFO']}"]
      @result.status = 404
    end
  end

  def map_date(key)
    month = { year: '%Y', month: '%M', day: '%d', hour: '%k', minute: '%M', second: '%S' }
    if month[key].nil?
      @result.status = 400
      @errors.push(key.to_s)
    else
      month[key]
    end
  end

end