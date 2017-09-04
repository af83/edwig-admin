require 'edwig'

server = Edwig::Server.new("http://edwig-dev.af83.priv", token: '03b39885444ee1df9fb4136f952621313f9c182a445d9f3f6718683b8bba942a', debug: true)

referential = server.find_referential_by_slug "test"
referential.destroy if referential

referential = server.create_referential(slug: "test", tokens: ["secret"])

server.find_referential referential.id

referential.tokens = %w{dummy secret}
referential.save

referential.create_partner slug: "first"
partner = referential.create_partner slug: "second"

puts referential.partners.inspect
puts referential.find_partner "first"
puts referential.find_partner partner.id

partner.settings = { "dummy": "true" }
partner.save

partner.destroy

referential.destroy
