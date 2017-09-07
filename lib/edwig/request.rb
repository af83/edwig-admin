module Edwig
  class Request
    attr_accessor :method, :path, :base_url, :token, :debug, :body

    def initialize(method, path, body, options = {})
      self.method, self.path, self.body = method, path, body
      options.each { |k,v| send "#{k}=", v }

      %i{method path base_url}.each do |attribute|
        raise "No #{attribute}" if send(attribute).blank?
      end
    end

    def headers
      { content_type: :json }.tap do |headers|
        headers[:authorization] = "Token token=#{token}" if token
      end
    end

    def log(message)
      Rails.logger.debug message if debug
    end

    def execute
      if body && !body.try(:acts_like_string?)
        self.body = body.to_json
      end

      log "#{method.upcase} #{base_url}/#{path} #{body} #{headers.inspect}"

      arguments = [ "#{base_url}/#{path}" ]
      arguments << body if method.in?([:post, :put])
      arguments << headers

      response =
        begin
          RestClient.send method, *arguments
        rescue RestClient::ExceptionWithResponse => err
          log "RestClient::ExceptionWithResponse #{err.response.body}"

          unless err.http_code.in?([406,400])
            raise err
          end

          err.response
        end

      log "#{response.code} #{response.body}"

      JSON.parse response
    end

  end
end
