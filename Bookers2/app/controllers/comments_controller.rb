class CommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = Comment.new(comment_params)
    #byebug
    comment.user_id = current_user.id
    comment.book_id = book.id
    
    comment.save
    redirect_to book_path(book.id)

  end

  def destroy
    book = Book.find(params[:book_id])
    comment = Comment.find(params[:id])
    
    comment.destroy
    redirect_to book_path(book.id)

  end


  private

  def comment_params
    params.require(:comment).permit(:comment)

  end

end
