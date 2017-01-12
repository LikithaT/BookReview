class BooksController < ApplicationController

	before_action :find_book, only: [:show, :edit, :update, :destroy]
	def index
	#@books = Book.where("category_id IN (?)", '3').page(params[:page])
	#@books = Book.order(:category_id).page(params[:page]).per(5)
	@books = Book.all.order("category_id DESC").includes(:category).page

if params[:category].blank?
	@books = Book.order(:category_id).includes(:category).page(params[:page])
  #respond_to do |format|
   # format.html
    #format.json { render json: BooksDatatable.new(view_context) }
else
	@category_id = Category.find_by(name: params[:category]).id
	@books = Book.where(:category_id => @category_id).order("created_at DESC").includes(:category)
end

end
def show

end
#def query
#	@books = book.where(:Category => Biography)
#	end

def new
	@book = current_user.books.build
    @book = Book.new
	@categories = Category.all.map{ |c| [c.name, c.id] }
	respond_to do |format|
	format.html 
		format.js
	end

end

def create
	@book = current_user.books.build(book_params)
	@books = Book.all
	@book.category_id = params[:category_id]
	respond_to do |format|
		if @book.save
	format.html { redirect_to root_path }
	format.js { redirect_to root_path }
	else
	format.html {render :new}
	format.js
end
end

end
def edit
	@categories = Category.all.map{ |c| [c.name, c.id] }
	format.html { redirect_to book_path(@book) }
		format.js
end
def update
		@book.category_id = params[:category_id]
		respond_to do |format|
	if @book.update(book_params)
		format.html { redirect_to book_path(@book) }
		format.js
		#@books=  Book.page(@params[:page]).per(8)
	else
		format.html { render :edit }
		format.js
	end
end
end
def destroy
	 @book.destroy
	redirect_to root_path
end



private

def book_params
	params.require(:book).permit(:title, :description, :author, :category_id)
end
def find_book
@book = Book.find(params[:id])	
end
end
