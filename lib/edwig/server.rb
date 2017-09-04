# TODO to be moved to edwig-ruby
module Edwig
  class Server
    attr_accessor :base_url, :token, :debug
    def initialize(base_url, attributes = {})
      self.base_url = base_url
      attributes.each { |k,v| send "#{k}=", v }
    end

    def http_options(options = {})
      { token: token, debug: debug }.merge(options).merge(base_url: base_url)
    end

    def get(path, options = {})
      Request.new(:get, path, nil, http_options(options)).execute
    end

    def post(path, body, options = {})
      Request.new(:post, path, body, http_options(options)).execute
    end

    def put(path, body, options = {})
      Request.new(:put, path, body, http_options(options)).execute
    end

    def delete(path, options = {})
      Request.new(:delete, path, nil, http_options(options)).execute
    end

    def referentials
      Referential.from_json self, get("_referentials")
    end

    def find_referential(id)
      Referential.from_json self, get("_referentials/#{id}")
    rescue RestClient::NotFound
      nil
    end

    def find_referential_by_slug(slug)
      referentials.find { |r| r.slug == slug }
    end

    def create_referential(attributes = {})
      Referential.new(self, attributes).tap(&:save)
    end
  end
end
