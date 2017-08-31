class Referential
  attr_reader :id, :slug, :token, :next_reload_at, :partner

  def initialize(id: nil, slug:, token:, next_reload_at: nil, partner:)
    @id = id
    @slug = slug
    @token = token
    @next_reload_at = next_reload_at
    @partner = partner
  end
end
