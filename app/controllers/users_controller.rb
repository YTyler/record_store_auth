class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @album.album_cover_photo.attach(params[:album][:album_cover_photo])
    if @user.save
      flash[:notice] = "You've successfully signed up!"
      session[:user_id] = @user.id
      redirect_to "/albums"
    else
      flash[:alert] = "There was a problem signing up."
      redirect_to '/signup'
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def update
    @user = User.find(params[:id])
    @user.profile_pic.attach(params[:user][:profile_pic])
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/users/#{@user.id}"
    else
      redirect_to "/users/#{@user.id}/edit"
    end
  end

private
  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :admin)
  end

end
