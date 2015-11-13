class PinsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
      @pins = Pin.all
  end

  # new
  def new
    @user = current_user
    @pin = current_user.pins.new
  end


  # create
  def create
    @user = current_user
    @pin = current_user.pins.create!(pins_params)
    redirect_to user_path(current_user.id)
  end

  #show
  def show
    @user = User.find(params[:user_id])
  end

  # edit
  def edit
    @user = params[:user_id]
    @pin_id = params[:id]
    @pin = current_user.pins.find(params[:id])
  end

  def update
    @pin = Pin.find(params[:id])
    @pin.update(pins_params.merge(user: current_user))

      redirect_to user_pin_path(current_user.id, params[:id])
    end

    # destroy
   def destroy
     @pin.destroy
     redirect_to user_path(current_user.id)
   end

   def set_post
     @pin = Pin.find(params[:id])
   end

   private
   def pins_params
     params.require(:pin).permit(:title, :photo_url, :youtube_link, :user_id)
   end
end
