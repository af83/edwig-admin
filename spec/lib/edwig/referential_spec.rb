require "rails_helper"
require 'edwig'

RSpec.describe Edwig::Referential do

  let(:server) { double }
  let(:referential) { Edwig::Referential.new server }

  describe "constructor" do
    it "should store given server" do
      referential = Edwig::Referential.new(server)
      expect(referential.server).to eq(server)
    end
    it "should store given attributes" do
      referential = Edwig::Referential.new(server, { id: "dummy" })
      expect(referential.id).to eq("dummy")
    end
  end

  describe "#get" do
    it "should invoke server get with :slug/:path"
    it "should use default_token as token"
  end

  describe "#delete" do
    it "should invoke server delete with :slug/:path"
    it "should use default_token as token"
  end

  describe "#post" do
    it "should invoke server post with :slug/:path"
    it "should use given body"
    it "should use default_token as token"
  end

  describe "#put" do
    it "should invoke server put with :slug/:path"
    it "should use given body"
    it "should use default_token as token"
  end

  describe ".from_json" do
    it "should store given server" do
      referential = Edwig::Referential.from_json(server)
      expect(referential.server).to eq(server)
    end
    it "should store json data as attributes" do
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

      expect(referential.id).to eq("a6ce5f93-6653-456e-a6f8-a003cddf5585")
      expect(referential.slug).to eq("test")
      expect(referential.next_reload_at).to eq("2017-09-01T04:00:00+02:00")
      expect(referential.partner_ids).to eq(["5ae4e41a-6ba5-45c8-bdda-ab14042b4437"])
    end
  end

  describe "#default_tokens" do
    it "should use the first token"
    it "should return nil when no token is defined"
  end

  describe "#next_reload_at" do
    it "should return a datetime" do
      string_time = "2017-09-01T04:00:00+02:00"
      referential = Edwig::Referential.new(server, next_reload_at: string_time)
      expect(referential.next_reload_at).to eq(DateTime.parse(string_time))
    end
  end

  describe "#partner_ids" do
    it "should return identifiers given by Partners json data"
  end

  describe "#partners" do
    it "should return partners defined in API" do
      expect(referential).to receive(:get).with("partners") do
        [ { "Slug" => "first" } ]
      end

      expected_attributes = { slug: "first" }
      expected_partner = Edwig::Partner.new(referential, expected_attributes)

      expect(referential.partners).to eq([ expected_partner ])
    end
  end

  describe "#create_partner" do
    it "should submit to the API the new Partner attributes" do
      expected_body = {
        Slug: "test",
        ConnectorTypes: [],
        Settings: {}
      }
      expect(referential).to receive(:post).with("partners", expected_body)

      referential.create_partner slug: "test"
    end
    it "should return a Partner with data retrieved from the API" do
      allow(referential).to receive(:post) do
        {
          "Id" => "a6ce5f93-6653-456e-a6f8-a003cddf5585",
          "Slug" => "test"
        }
      end

      partner = referential.create_partner slug: "test"
      expected_attributes = {
        "id" => "a6ce5f93-6653-456e-a6f8-a003cddf5585",
        "slug" => "test"
      }
      expect(partner.attributes).to include(expected_attributes)
    end
  end

  describe "#find_partner" do
    let(:id) { "a6ce5f93-6653-456e-a6f8-a003cddf5585" }

    it "should return Partner with data retrieved from the API" do
      expect(referential).to receive(:get).with("partners/#{id}") do
        {
          "Id" => id,
          "Slug" => "test"
        }
      end

      partner = referential.find_partner id
      expected_attributes = {
        "id" => id,
        "slug" => "test",
      }
      expect(partner.attributes).to include(expected_attributes)
    end

    context "when the API returns 404" do
      it "should return nil" do
        allow(referential).to receive(:get).with("partners/#{id}").and_raise(RestClient::NotFound)
        expect(referential.find_partner(id)).to be_nil
      end
    end
  end

  describe "#save" do
    context "when Referential has no id" do
      it "should send a POST request to _referentials"
      it "should send attributes as json data to API"
      it "should update attributes with data retrieved from API"
    end

    context "when Referential has an id" do
      it "should send a PUT request to _referentials/:id"
      it "should send attributes as json data to API"
      it "should update attributes with data retrieved from API"
    end
  end

  describe "#destroy" do
    it "should send a DELETE request to _referentials/:id"
    it "should reset Referential id"

    context "when Referential has no id" do
      it "should not send a DELETE request"
    end
  end

  describe "#to_api_json" do
    it "should include slug as Slug"
    it "should include tokens as Tokens"
  end

end
