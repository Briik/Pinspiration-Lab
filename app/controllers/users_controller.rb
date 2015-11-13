class UsersController < ApplicationController

def index
  authenticate_user!
  @users = User.all
end

def show
  #@user = User.find(params[:id])
  @user = current_user
end

def new
  @user = User.new
end

def create
  @user = User.new(artist_params)
  if @user.save
    flash[:notice] = "#{@user.name} was successfully created."
    redirect_to @user
  else
    render :new
  end
 end

def edit
  @user = User.find(params[:id])
end

def update
  @user = User.find(params[:id])
  @user.update(pins_params)
  redirect_to user_path(@user)
end

def destroy
  @user = User.find(params[:id])
  @user.destroy
  redirect_to user_path
end

private
def user_params
  params.require(:user).permit(:name, :email)
end
end
