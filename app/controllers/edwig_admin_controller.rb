class EdwigAdminController < ApplicationController
    require 'rest-client'
    require 'json'
    before_filter :authenticate_user!


    def index
        referentials = RestClient.get("http://localhost:8080/_referentials", {content_type: :json, :Authorization => "Token token=6ceab96a-8d97-4f2a-8d69-32569a38fc64"})
        @referentialsTab = JSON.parse(referentials)

        #referentialsTab.each {|referential| puts referential}
    end

    def show

    end

    def new

    end

    def create

    end

    def edit

    end

    def update

    end

    def destroy

    end
end