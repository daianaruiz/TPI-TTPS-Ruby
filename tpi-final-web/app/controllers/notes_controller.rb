class NotesController < ApplicationController
  before_action :find_book
  before_action :set_note, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /notes or /notes.json
  def index
    @notes = @book.notes
  end


  # GET /notes/1 or /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = @book.notes.build
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes or /notes.json
  def create
    @note = @book.notes.build(note_params)
    if @note.save
      redirect_to book_notes_path(@book), notice: "La nota se creó correctamente."
    else
      render :new, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /notes/1 or /notes/1.json
  def update
    if @note.update(note_params)
      redirect_to book_notes_path(@book), notice: "La nota se actualizó correctamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    @note.destroy
    redirect_to book_notes_path(@book), notice: "La nota se borró correctamente."
  end

  def find_book
    @book = Book.find(params[:book_id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = @book.notes.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:book_id, :title, :content)
    end
end
