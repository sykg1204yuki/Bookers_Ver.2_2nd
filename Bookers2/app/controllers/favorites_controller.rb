class FavoritesController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    favorite = Favorite.new(book_id: book.id)
    #byebug
    favorite.user_id = current_user.id
    favorite.save
    redirect_back(fallback_location: root_path)

  end

  def destroy
    book = Book.find(params[:book_id])
    Favorite.find_by(book_id: book.id).destroy
      #favorite = Favorite.find_by(book_id: book.id)
      #favorite.destroy       の省略
    redirect_to request.referer
      #redirect_back(fallback_location: root_path)    でも可

  end


end
