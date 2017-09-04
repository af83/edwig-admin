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

    def execute
      if body && !body.try(:acts_like_string?)
        self.body = body.to_json
      end

      if debug
        puts "#{method.upcase} #{base_url}/#{path} #{body} #{headers.inspect}"
      end

      arguments = [ "#{base_url}/#{path}" ]
      arguments << body if method.in?([:post, :put])
      arguments << headers

      response = RestClient.send method, *arguments

      if debug
        puts "#{response.code} #{response.body}"
      end

      JSON.parse response
    rescue RestClient::ExceptionWithResponse => err
      puts err.response.body
      raise err
    end

  end
end
