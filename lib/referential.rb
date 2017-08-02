class Referential
  attr_reader :id, :slug, :token, :next_reload_at

  def initialize(id: nil, slug:, token:, next_reload_at: nil)
    @id = id
    @slug = slug
    @token = token
    @next_reload_at = next_reload_at
  end
end
