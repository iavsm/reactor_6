# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :required_user, only: %i[edit update destroy]
  before_action :required_same_user, only: %i[edit update destroy]

  def show
    @article = @user.articles.paginate(page: params[:page], per_page: 1)
  end

  def index
    @user = User.paginate(page: params[:page], per_page: 1)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(get_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'Welcome to Reactor6'
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(get_params)
      flash[:notice] = 'User updated successfully'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = 'User and all releated article are deleted'
    redirect_to articles_path
  end

  private

  def get_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def required_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = 'You logged in with different user'
      redirect_to @user
    end
  end
end
