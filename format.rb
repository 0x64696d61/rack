class Format

  FORMAT = { year: '%Y', month: '%M', day: '%d', hour: '%k', minute: '%M', second: '%S' }.freeze

  def initialize(request)
    @request     = request
    @errors      = []
    @time_string = ''
  end


  def formatted_time
    if validation
      matching(@request.params["format"].split(','))
      if @errors.empty?
        t = Time.now
        Rack::Response.new([t.strftime(@time_string.chop!)], 200)
      else
        Rack::Response.new(["Unknown time format #{@errors}"], 400)
      end
    else
      Rack::Response.new(["Unknown time format #{@request.path_info}"], 404)
    end
  end

  private

  def matching(keys)
    keys.each do |key|
      if FORMAT[key.to_sym].nil?
        @errors.push(key)
      else
        format_time_string(FORMAT[key.to_sym])
      end
    end
  end

  def format_time_string(key)
    @time_string << key << '-'
  end

  def validation
    @request.path_info == '/time'
  end
end