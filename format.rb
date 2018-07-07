class Format
  attr_reader :errors, :time_string

  FORMAT = { year: '%Y', month: '%M', day: '%d', hour: '%k', minute: '%M', second: '%S' }.freeze

  def initialize(keys)
    @errors      = []
    @time_string = ''
    matching(keys)
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