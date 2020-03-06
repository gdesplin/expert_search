class ExpertsController < ApplicationController

  def index
    @experts = Expert.all
  end

  def show
    @expert = Expert.find(params[:id])
  end

  def new
    @expert = Expert.new
  end

  def edit
    @expert = Expert.find(params[:id])
  end

  def create
    @expert = Expert.new(safe_params)
    if @expert.save
      flash.notice = "Expert created."
      redirect_to @expert
    else
      flash.now.alert = "Error count: #{@expert.errors.size}, see below."
      render :new
    end
  end

  def update
    @expert = Expert.find(params[:id])
    if @expert.updatew(safe_params)
      flash.notice = "Expert updated."
      redirect_to @expert
    else
      flash.now.alert = "Error count: #{@expert.errors.size}, see below."
      render :new
    end
  end

  private

  def safe_params
    params.require(:expert).permit(%i[name personal_website_url])
  end


end
