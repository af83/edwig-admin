require 'rest-client'
require 'json'
class ReferentialsController < ApplicationController
  before_filter :authenticate_user!

  def index
    referentials = RestClient.get("#{Rails.configuration.edwig_api_host}/_referentials", {content_type: :json, :Authorization => "Token token=#{Rails.configuration.edwig_token}"})
    @referentials_tab = JSON.parse(referentials)
    @referentials_tab.sort_by! {|referential| referential["Slug"]}
  end

  def show

  end

  def partners

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
    destroy_referentials = RestClient.delete("#{Rails.configuration.edwig_api_host}/_referentials/#{params[:slug]}", {content_type: :json, :Authorization => "Token token=#{Rails.configuration.edwig_token}"})
    redirect_to referentials_path
  end
end