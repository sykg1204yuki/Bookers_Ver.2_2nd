class UsersController < ApplicationController

  before_action :ensure_current_user, {only: [:edit,:update]}

  def ensure_current_user
    user = User.find(params[:id])
      if user != current_user
        redirect_to user_path(current_user)

      end
  end


  def show
    @user = User.find(params[:id])
    @books = @user.books.all #Userモデルの中のbookを全て表示
    @book = Book.new

  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new

  end

  def edit
    @user = User.find(current_user.id)

  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(current_user)
    else
      render :edit

    end

  end

  private

  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)

  end


end
