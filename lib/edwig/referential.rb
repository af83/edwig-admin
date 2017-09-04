# TODO to be moved to edwig-ruby
module Edwig
  class Referential < Model
    attr_reader :server

    def initialize(server, attributes = {})
      super attributes

      @server = server
    end

    def get(path)
      server.get "#{slug}/#{path}", token: default_token
    end

    def post(path, body)
      server.post "#{slug}/#{path}", body, token: default_token
    end

    def put(path, body)
      server.put "#{slug}/#{path}", body, token: default_token
    end

    def delete(path)
      server.delete "#{slug}/#{path}", token: default_token
    end

    def default_token
      tokens.try :first
    end

    attribute :id
    attribute :slug
    attribute :tokens, default: []
    attribute :next_reload_at, type: DateTime
    attribute :partner_ids, default: []
    alias_method :'partners=', :'partner_ids='

    def partners
      Partner.from_json self, get("partners")
    end

    def create_partner(attributes = {})
      Partner.new(self, attributes).tap(&:save)
    end

    def find_partner(id)
      Partner.from_json self, get("partners/#{id}")
    rescue RestClient::NotFound
      nil
    end

    def save
      if persisted?
        server.put("_referentials/#{id}", to_api_json)
      else
        self.attributes = api_attributes(server.post("_referentials", to_api_json))
        id.present?
      end
    end

    def destroy
      server.delete "_referentials/#{id}"
      # TODO
    end

    def to_api_json
      { "Slug": slug, "Tokens": tokens }
    end

  end
end
