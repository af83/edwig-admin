class Partner
  attr_reader :id, :slug, :token, :partner_status, :connector_types, :settings_remote_credentials

  def initialize(id: nil, slug:, token: nil, partner_status: nil, connector_types:, settings_remote_credentials:)
    @id = id
    @slug = slug
    @token = token
    @partner_status = partner_status
    @settings_remote_credentials = settings_remote_credentials
    @connector_types = connector_types
  end
end

# class Partner
#   attr_reader :id, :slug, :token, :settings_remote_url, :connector_types, :settings_remote_credential, :settings_local_credential, :settings_remote_objectid_kind
#
#   def initialize(id: nil, slug:, token: nil, settings_remote_url:, connector_types:, settings_remote_credential:, settings_local_credential:, settings_remote_objectid_kind: )
#     @id = id
#     @slug = slug
#     @token = token
#     @settings_remote_url = settings_remote_url
#     @connector_types = connector_types
#     @settings_remote_credential = settings_remote_credential
#     @settings_local_credential = settings_local_credential
#     @settings_remote_objectid_kind = settings_remote_objectid_kind
#   end
# end