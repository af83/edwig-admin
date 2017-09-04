require "rails_helper"
require 'edwig'

RSpec.describe Edwig::Partner do

  let(:referential) { double }

  describe "constructor" do
    it "should store given referential" do
      partner = Edwig::Partner.new(referential)
      expect(partner.referential).to eq(referential)
    end
    it "should store given attributes" do
      partner = Edwig::Partner.new(referential, { id: "dummy" })
      expect(partner.id).to eq("dummy")
    end
  end

  describe ".from_json" do
    it "should store given referential" do
      partner = Edwig::Partner.from_json(referential)
      expect(partner.referential).to eq(referential)
    end
    it "should store json data as attributes" do
      json = %{
        {
          "Id": "a6ce5f93-6653-456e-a6f8-a003cddf5585",
          "Slug": "test",
          "Settings": {
            "key": "value"
          },
          "ConnectorTypes": [ "dummy" ]
        }
      }

      partner = Edwig::Partner.from_json(referential, JSON.parse(json))

      expect(partner.id).to eq("a6ce5f93-6653-456e-a6f8-a003cddf5585")
      expect(partner.slug).to eq("test")
      expect(partner.settings).to eq({"key" => "value"})
      expect(partner.connector_types).to eq(["dummy"])
    end
  end

  describe "#connector_types" do
    it "should return empty array by default"
  end

  describe "#settings" do
    it "should return empty hash by default"
  end

  describe "#save" do
    context "when Partner has no id" do
      it "should send a POST request to partners"
      it "should send attributes as json data to API"
      it "should update attributes with data retrieved from API"
    end

    context "when Partner has an id" do
      it "should send a PUT request to partners/:id"
      it "should send attributes as json data to API"
      it "should update attributes with data retrieved from API"
    end
  end

  describe "#destroy" do
    it "should send a DELETE request to partners/:id"
    it "should reset Partner id"

    context "when Partner has no id" do
      it "should not send a DELETE request"
    end
  end

  describe "#to_api_json" do
    it "should include slug as Slug"
    it "should include tokens as Tokens"
  end

end
