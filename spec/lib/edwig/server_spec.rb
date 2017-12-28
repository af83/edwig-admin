require "rails_helper"
require 'edwig'

RSpec.describe Edwig::Server do

  let(:server) { Edwig::Server.new "http://edwig" }

  describe "constructor" do
    it "should store given base_url" do
      server = Edwig::Server.new("http://dummy")
      expect(server.base_url).to eq("http://dummy")
    end
    it "should store given token" do
      server = Edwig::Server.new("http://dummy", token: "secret")
      expect(server.token).to eq("secret")
    end
    it "should store given debug" do
      server = Edwig::Server.new("http://dummy", debug: true)
      expect(server.debug).to be(true)
    end
  end

  describe "http_options" do
    it "should set default token value" do
      server.token = "dummy"
      expect(server.http_options).to include(token: server.token)
    end
    it "should set default debug value" do
      server.debug = true
      expect(server.http_options).to include(debug: server.debug)
    end
    it "should include given options" do
      options = { key: "value" }
      expect(server.http_options(options)).to include(options)
    end
    it "should override base_url" do
      options = { base_url: "wrong" }
      expect(server.http_options(options)).to include(base_url: server.base_url)
    end
  end

  describe "#get" do
    it "should send GET request to the server with given path" do
      api_response = {"key" => "value"}
      FakeWeb.register_uri :get, "http://edwig/path", body: api_response.to_json
      expect(server.get("path")).to eq(api_response)
    end
    it "should use token in Authorization header" do
      api_response = {"key" => "value"}
      FakeWeb.register_uri :get, "http://edwig/path", body: api_response.to_json
      server.token = "secret"
      server.get("path")
      expect(FakeWeb.last_request["authorization"]).to eq('Token token=secret')
    end
  end

  describe "#delete" do
    it "should send DELETE request to the server with given path"
    it "should use token in Authentication header"
  end

  describe "#post" do
    it "should send POST request to the server with given path"
    it "should include the given body in the request"
    it "should use token in Authentication header"
  end

  describe "#put" do
    it "should send PUT request to the server with given path"
    it "should include the given body in the request"
    it "should use token in Authentication header"
  end

  describe "#referentials" do
    it "should return referentials defined in API" do
      expect(server).to receive(:get).with("_referentials") do
        [
          {
            "Id" => "a6ce5f93-6653-456e-a6f8-a003cddf5585",
           "Slug" => "test",
           "NextReloadAt" =>  "2017-09-01T04:00:00+02:00",
           "Partners" => [ "5ae4e41a-6ba5-45c8-bdda-ab14042b4437" ]
          }
        ]
      end

      expected_attributes = {
        id: "a6ce5f93-6653-456e-a6f8-a003cddf5585",
        slug: "test",
        next_reload_at: "2017-09-01T04:00:00+02:00",
        partner_ids: [ "5ae4e41a-6ba5-45c8-bdda-ab14042b4437" ]
      }
      expected_referential = Edwig::Referential.new(server, expected_attributes)

      expect(server.referentials).to eq([expected_referential])
    end
  end

  describe "#create_referential" do
    it "should submit to the API the new Referential attributes" do
      expected_body = {
        "Slug": "test",
        "Tokens": [ "secret" ],
        "Settings": {}
      }
      expect(server).to receive(:post).with("_referentials", expected_body)

      server.create_referential slug: "test", tokens: %w{secret}
    end
    it "should return a Referential with data retrieved from the API" do
      allow(server).to receive(:post) do
        {
          "Id" => "a6ce5f93-6653-456e-a6f8-a003cddf5585",
          "Slug" => "test",
          "NextReloadAt" =>  "2017-09-01T04:00:00+02:00"
        }
      end

      referential = server.create_referential slug: "test"
      expected_attributes = {
        "id" => "a6ce5f93-6653-456e-a6f8-a003cddf5585",
        "slug" => "test",
        "next_reload_at" => DateTime.parse("2017-09-01T04:00:00+02:00"),
      }
      expect(referential.attributes).to include(expected_attributes)
    end
  end

  describe "#find_referential" do
    let(:id) { "a6ce5f93-6653-456e-a6f8-a003cddf5585" }
    it "should return Referential with data retrieved from the API" do
      expect(server).to receive(:get).with("_referentials/#{id}") do
        {
          "Id" => id,
          "Slug" => "test",
          "NextReloadAt" =>  "2017-09-01T04:00:00+02:00"
        }
      end

      referential = server.find_referential id
      expected_attributes = {
        "id" => id,
        "slug" => "test",
        "next_reload_at" => DateTime.parse("2017-09-01T04:00:00+02:00"),
      }
      expect(referential.attributes).to include(expected_attributes)
    end

    context "when the API returns 404" do
      it "should return nil" do
        allow(server).to receive(:get).with("_referentials/#{id}").and_raise(RestClient::NotFound)
        expect(server.find_referential(id)).to be_nil
      end
    end
  end

  describe "#find_referential_by_slug" do
    it "should retrieve the API referentials" do
      expect(server).to receive(:referentials) do
        [ Edwig::Referential.new(server) ]
      end
      server.find_referential_by_slug "dummy"
    end
    it "should return the Referential with given slug" do
      allow(server).to receive(:referentials) do
        %w{wrong dummy}.map { |slug| Edwig::Referential.new server, slug: slug }
      end
      expect(server.find_referential_by_slug("dummy").slug).to eq("dummy")
    end

    context "when no Referential has the given slug" do
      it "should return nil" do
        allow(server).to receive(:referentials) do
          [ Edwig::Referential.new(server) ]
        end
        expect(server.find_referential_by_slug("dummy")).to be_nil
      end
    end
  end

end
