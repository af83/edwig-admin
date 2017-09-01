require "rails_helper"
require 'edwig'

RSpec.describe Edwig::Referential do

  let(:server) { double }

  it "can be created with server and attribute" do
    referential = Edwig::Referential.new(server, { id: "dummy" })

    expect(referential.server).to eq(server)
    expect(referential.id).to eq("dummy")
  end

  it "can be created with server and json data" do
    json = %{
      {
        "Id": "a6ce5f93-6653-456e-a6f8-a003cddf5585",
        "Slug": "test",
        "NextReloadAt": "2017-09-01T04:00:00+02:00",
        "Partners": [
          "5ae4e41a-6ba5-45c8-bdda-ab14042b4437"
        ]
      }
    }

    referential = Edwig::Referential.from_json(server, JSON.parse(json))

    expect(referential.server).to eq(server)
    expect(referential.id).to eq("a6ce5f93-6653-456e-a6f8-a003cddf5585")
    expect(referential.slug).to eq("test")
    expect(referential.next_reload_at).to eq("2017-09-01T04:00:00+02:00")
    expect(referential.partner_ids).to eq(["5ae4e41a-6ba5-45c8-bdda-ab14042b4437"])
  end

  describe "#next_reload_at" do
    it "should return a datetime" do
      string_time = "2017-09-01T04:00:00+02:00"
      referential = Edwig::Referential.new(server, next_reload_at: string_time)
      expect(referential.next_reload_at).to eq(DateTime.parse(string_time))
    end
  end

  describe "#partners" do
    it "should return partners defined in API"
  end

end
