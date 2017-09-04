require 'rest-client'
require 'json'
require 'partner'

class PartnersController < ApplicationController
  def index
    @partners = referential.partners
  end

  def show

  end

  def new
    @partner = Edwig::Partner.new referential
  end

  def create
    @partner = referential.create_partner params[:partner]

    if @partner.valid?
      redirect_to referential_partners_path(referential.id)
    else
      render :new
    end
  end

  def edit
    @partner = referential.find_partner params[:id]
  end

  def update
    @partner = referential.find_partner params[:id]

    @partner.attributes = params[:partner]

    if @partner.save
      redirect_to referential_partners_path(referential.id)
    else
      render :edit
    end
  end

  def referential
    @referential ||= edwig_server.find_referential params[:referential_id]
  end

  def destroy
    partner = referential.find_partner params[:id]
    partner.destroy
    redirect_to referential_partners_path(referential.id)
  end
end
