class Format

  attr_reader :errors, :result

  FORMAT = { year: '%Y', month: '%M', day: '%d', hour: '%k', minute: '%M', second: '%S' }.freeze

  def initialize(request)
    @request     = request
    @errors      = []
    @time_string = ''
    @result      = nil
    formatted_time
  end

  private

  def formatted_time
    matching(@request["format"].split(','))
    if @errors.empty?
      t       = Time.now
      @result = t.strftime(@time_string.chop!)
    end
    nil
  end

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

end