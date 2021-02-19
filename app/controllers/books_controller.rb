class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: %i[ show edit update destroy convert_book_notes]

  # GET /books or /books.json
  def index
    @books = Book.where(user_id: current_user.id)
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
    if @book.save
      redirect_to book_notes_path(@book), notice: "El cuaderno se creó correctamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    authorize @book
    if @book.update(book_params)
      redirect_to book_notes_path(@book), notice: "El cuaderno se actualizó correctamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    if @book.is_global
      Note.where(book_id: @book.id).delete_all
      redirect_to books_url, notice: "Las notas de global se borraron correctamente"
    else
      @book.destroy
      redirect_to books_url, notice: "El cuaderno se borró correctamente"
    end
  end

  def convert_book_notes
    @converted_notes = []
    @book.notes.each do |note|
      @converted_notes << CommonMarker.render_html("# __#{note.title}__ \n" + note.content)
    end
  end
  
  def convert_user_notes
    @converted_notes = []
    current_user.books.each do |book|
      if book.notes.any?
        @converted_notes << CommonMarker.render_html("# __#{book.title}__")
        book.notes.each do |note|
          @converted_notes << CommonMarker.render_html("# __#{note.title}__ \n" + note.content)
        end
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
