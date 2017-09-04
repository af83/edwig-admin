module Edwig
  class Partner < Model

    attr_reader :referential

    def initialize(referential, attributes = {})
      super attributes
      @referential = referential
    end

    attribute :id
    attribute :slug
    attribute :operationnal_status
    attribute :service_started_at
    attribute :connector_types, default: []
    attribute :settings, default: {}

    def partner_status=(attributes = {})
      self.attributes = attributes.transform_keys(&:underscore)
    end

    def save
      if persisted?
        referential.put("partners/#{id}", to_api_json)
      else
        self.attributes = api_attributes(referential.post("partners", to_api_json))
        id.present?
      end
    end

    def destroy
      referential.delete "partners/#{id}"
    end

    def to_api_json
      { "Slug": slug, "ConnectorTypes": connector_types, "Settings": settings }
    end

  end
end
