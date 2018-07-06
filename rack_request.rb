class RackRequest
  attr_accessor :status, :header, :body

  def initialize
    default
  end

  def valid?
    @status == 200
  end

  def default
    @status = default_status
    @header = default_header
    @body   = default_body
  end

  private

  def default_status
    200
  end

  def default_header
    { 'Content-Type' => 'text/plain' }
  end

  def default_body
    ["Welcome"]
  end

end