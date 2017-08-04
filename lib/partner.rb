class Partner
  attr_reader :id, :slug, :token, :status, :connector_types

  def initialize(id: nil, slug:, token: nil, status: nil, connector_types: nil)
    @id = id
    @slug = slug
    @token = token
    @status = status
    @connector_types = connector_types
  end
end