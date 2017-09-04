require 'rest-client'
require 'json'
require 'referential'

class ReferentialsController < ApplicationController
  before_action :authenticate_user!

  def index
    @referentials = edwig_server.referentials.sort_by!(&:slug)
  end

  def show
    @referential = edwig_server.find_referential params[:id]
  end

  def new
    @referential = Edwig::Referential.new(edwig_server)
  end

  def create
    @referential = edwig_server.create_referential params[:referential]

    if @referential.valid?
      redirect_to referentials_path
    else
      render :new
    end
  end

  def edit
    @referential = edwig_server.find_referential params[:id]
  end

  def update
    @referential = edwig_server.find_referential params[:id]
    @referential.attributes = params[:referential]

    if @referential.save
      redirect_to referentials_path
    else
      render :edit
    end
  end

  def destroy
    referential = edwig_server.find_referential params[:id]
    referential.destroy
    redirect_to referentials_path
  end
end
