class Partner
  attr_reader :slug, :settings_remote_url, :connector_types

  def initialize(slug:, settings_remote_url:, connector_types:)
    @slug = slug
    @settings_remote_url = settings_remote_url
    @connector_types = connector_types
  end
end
