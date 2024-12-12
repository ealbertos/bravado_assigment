class ApplicationController < ActionController::API
  before_action :authenticate_request!

  protected

  def authenticate_request!
    head(:forbidden) unless api_token
  end

  def api_token
    @api_token ||= ApiToken.find_by(value: authorization_header)
  end

  def authorization_header
    pattern = /^Bearer /
    header = request.headers['Authorization']
    header.gsub(pattern, '') if header&.match(pattern)
  end

  rescue_from ActionController::ParameterMissing do |e|
    head(:bad_request)
  end
end
