class PartnersController < ApplicationController
  def index
    # partners = RestClient.get("http://localhost:8080/#{@referentialsTab["Slug"]}", {content_type: :json, :Authorization => "Token token=#{@referentialsTab["Token"]}"})
    # @partnersTab = JSON.parse(partners)
  end
end
