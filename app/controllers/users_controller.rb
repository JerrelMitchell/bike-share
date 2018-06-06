class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
    not_found unless current_user?
  end

  def edit; end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path(@user)
    else
      flash[:notice] = 'That username is taken, or information submitted was incomplete. Try again.'
      render :new
    end
  end

  def update
    @user.update(user_params)
    if @user.update_attributes(user_params)
      redirect_to dashboard_path(@user), notice: 'User was successfully updated.'
    else
      flash[:notice] = 'Please make sure your passwords match!'
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: 'Sad to see you go. Rejoin anytime!'
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
