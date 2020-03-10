class BookCommentsController < ApplicationController
# before_action :authenticate_user!

	def create
		@book = Book.find(params[:book_id])
		@book_new =Book.new
		@book_comment = @book.book_comments.new(book_comment_params)
		@book_comment.user_id = current_user.id
		# @book_comment = Book_comment.new(book_comment_params)
		# @book_comment.book_id = @book.id
		if @book_comment.save
			flash[:success] = "Commet was successfully created."
			redirect_to book_path(@book)
	  else
	  	@book.comments = BookComment.where(book_id: @book.id)
	  	render 'books/show'
	  end
	end

	def destroy
		@book_comment = BookComment.find(params[:book_id])
		if @book_comment.user != current_user
			redirect_ to request.referer
		end
		@book_comment.destroy
		redirect_to request.referer
	end

	def edit
		@book_comment = BookComment.find(params[:book_id])
		# redirect_to books_path unless @book.comment_id == current_user.id
	end
	def update
		@book_comment = BookComment.find(params[:book_id])
		@book_comment.update(book_comment_params)
		redirect_to book_path(@book_comment.book)
	end

	private
	def book_comment_params
		params.require(:book_comment).permit(:comment)
	end
end
