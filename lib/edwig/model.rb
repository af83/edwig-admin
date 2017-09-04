module Edwig
  class Model

    include ActiveAttr::Attributes
    include ActiveAttr::MassAssignment
    include ActiveAttr::TypecastedAttributes
    include ActiveAttr::AttributeDefaults

    def self.from_json(referential, data = {})
      return if data.nil?

      if Array === data
        return data.map do |attributes|
          from_json referential, attributes
        end
      end

      data = api_attributes(data)
      new referential, data
    end

    def self.api_attributes(api_data)
      return {} if api_data.nil?
      api_data.transform_keys(&:underscore)
    end
    def api_attributes(api_data)
      self.class.api_attributes api_data
    end

    def persisted?
      id.present?
    end

    def valid?
      persisted?
    end

  end
end
