module Edwig
  class Partner

    attr_reader :referential

    def initialize(referential, attributes = {})
      @referential = referential
      self.attributes = attributes
    end

    def self.from_json(referential, data)
      if Array === data
        return data.map do |attributes|
          from_json referential, attributes
        end
      end

      data = data.transform_keys(&:underscore)
      Partner.new referential, data
    end

    include ActiveAttr::Attributes
    include ActiveAttr::MassAssignment
    include ActiveAttr::TypecastedAttributes

    attribute :id
    attribute :slug
    attribute :operationnal_status
    attribute :service_started_at
    attribute :connector_types
    attribute :settings

    def partner_status=(attributes = {})
      self.attributes = attributes.transform_keys(&:underscore)
    end

    def save
      if persisted?
        referential.put("partners/#{id}", to_api_json)
      else
        self.attributes = api_attributes(server.post("partners", to_api_json))
        id.present?
      end
    end

  end
end
