require "rails_helper"
require 'edwig'

RSpec.describe Edwig::Server do

  it "should store given token" do
    server = Edwig::Server.new("http://dummy", token: "secret")
    expect(server.token).to eq("secret")
  end

  describe "#get" do
    it "should send GET request to the server with given path" do
      # FakeWeb.register_uri :get, "http://edwig/_referentials", body: json_body

    end
    it "should use token in Authentication header" do
      # FakeWeb.last_request
    end
  end

  describe "#referentials" do
    it "should return referentials defined in API" do
      server = Edwig::Server.new("http://edwig",token: 'dummy', debug: true)

      expect(server).to receive(:get).with("_referentials") do
        JSON.parse(
        %{
           [
             {
               "Id": "a6ce5f93-6653-456e-a6f8-a003cddf5585",
               "Slug": "test",
               "NextReloadAt": "2017-09-01T04:00:00+02:00",
               "Partners": [
                 "5ae4e41a-6ba5-45c8-bdda-ab14042b4437"
               ]
             }
           ]
        }
        )
      end

      expected_referential = Edwig::Referential.new(server, {
                                 id: "a6ce5f93-6653-456e-a6f8-a003cddf5585",
                                 slug: "test",
                                 next_reload_at: "2017-09-01T04:00:00+02:00",
                                 partner_ids: [ "5ae4e41a-6ba5-45c8-bdda-ab14042b4437" ]
                               })

      expect(server.referentials).to eq([expected_referential])
    end
  end

  describe "#create_referential" do
    it "should submit to the API the new Referential attributes"
  end


end
