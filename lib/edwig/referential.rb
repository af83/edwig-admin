# TODO to be moved to edwig-ruby
module Edwig
  class Referential
    attr_reader :server

    def initialize(server, attributes = {})
      @server = server
      self.attributes = attributes
    end

    def get(path = "")
      server.get("#{slug}/#{path}", token: default_token)
    end

    def default_token
      tokens.try :first
    end

    def self.from_json(server, data)
      if Array === data
        return data.map do |attributes|
          from_json server, attributes
        end
      end

      Referential.new server, api_attributes(data)
    end

    def self.api_attributes(api_data)
      api_data.transform_keys(&:underscore)
    end
    def api_attributes(api_data)
      self.class.api_attributes api_data
    end

    include ActiveAttr::Attributes
    include ActiveAttr::MassAssignment
    include ActiveAttr::TypecastedAttributes

    attribute :id
    attribute :slug
    attribute :tokens
    attribute :next_reload_at, type: DateTime
    attribute :partner_ids
    alias_method :'partners=', :'partner_ids='

    def partners
      Partner.from_json self, get("partners")
    end

    def create_partner(attributes = {})
      Partner.new(self, attributes).tap(&:save)
    end

    def persisted?
      id.present?
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
      { "Slug": slug, "Tokens": tokens }.to_json
    end

  end
end
