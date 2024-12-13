# Handles all http requests using Faraday
class HttpClient
  attr_accessor :base_url, :headers
  attr_reader :response

  %i[get post patch delete].each do |verb|
    define_method(verb) do |url:, params: EMPTY_HASH|
      params = params.to_json if %i[post patch].include?(verb)
      @response = Faraday.new(base_url).public_send(verb, url, params, headers)
    end
  end
end
