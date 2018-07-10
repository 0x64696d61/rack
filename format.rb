class Format

  attr_reader :errors

  FORMAT = { year: '%Y', month: '%M', day: '%d', hour: '%k', minute: '%M', second: '%S' }.freeze

  def initialize(request)
    @request     = request
    @errors      = []
    @time_string = ''
  end


  def formatted_time
    matching(@request["format"].split(','))
    if @errors.empty?
      t = Time.now
      t.strftime(@time_string.chop!)
    else
      nil
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

end