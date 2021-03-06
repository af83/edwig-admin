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
    attribute :settings, default: {}

    def model_reload_at
      settings["model.reload_at"]
    end

    def model_reload_at=(value)
      (self.settings ||= {})["model.reload_at"] = value
    end

    def token_list
      tokens.join(',')
    end

    def token_list=(list)
      self.tokens = list.split(",")
    end

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

    def save_partners
      post("partners/save", {})
    end

    def save
      updated_attributes =
        if persisted?
          server.put("_referentials/#{id}", to_api_json)
        else
          server.post("_referentials", to_api_json)
        end
      self.attributes = api_attributes(updated_attributes)

      valid?
    end

    def valid?
      errors[:slug] = ["only accept alphanumeric characters"] unless slug.blank? || slug =~ /\A[a-zA-Z_0-9-]+\Z/
      errors[:model_reload_at] = ["must use HH:MM format"] unless model_reload_at =~ /\A[0-9]{2}:[0-9]{2}\Z/
      errors[:token_list] = ["can't be empty (via edwig admin)"] if token_list.blank?
      super
    end


    def destroy
      server.delete "_referentials/#{id}"
      # TODO
    end

    def to_api_json
      { "Slug": slug, "Tokens": tokens, "Settings": settings }
    end

  end
end
