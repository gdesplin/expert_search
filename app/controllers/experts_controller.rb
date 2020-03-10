class ExpertsController < ApplicationController

  def index
    @experts = Expert.search(search_params)
    respond_to do |format|
      format.html
      format.json { render json: @experts }
     end
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

  def add_friend
    expert = Expert.find(params[:id])
    friend = Expert.find(add_friend_params[:friend_id])
    expert.friends << friend
    expert.save
    render json: friend
  end

  def update
    @expert = Expert.find(params[:id])
    if @expert.update(safe_params)
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

  def search_params
    params.permit(%i[term field])
  end

  def add_friend_params
    params.permit(:friend_id)
  end


end
