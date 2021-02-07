class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /books or /books.json
  def index
    @books = Book.where(user_id: current_user.id)
  end

  # GET /books/1 or /books/1.json
  def show
    authorize @book
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    authorize @book
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    authorize @book
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    if @book.is_global
      Note.where(book_id: @book.id).delete_all
      respond_to do |format|
        format.html { redirect_to books_url, notice: "Las notas de global se borraron correctamente" }
      end
    else
      @book.destroy
      respond_to do |format|
        format.html { redirect_to books_url, notice: "El cuaderno se borró correctamente" }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title).merge(user: current_user)
    end
end
