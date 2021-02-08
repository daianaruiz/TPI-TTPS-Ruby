class NotesController < ApplicationController
  before_action :find_book
  before_action :set_note, only: %i[ show edit update destroy convert]
  before_action :authenticate_user!

  # GET /notes or /notes.json
  def index
    authorize @book, policy_class: NotePolicy
    @notes = @book.notes
  end


  # GET /notes/1 or /notes/1.json
  def show
    authorize @book, policy_class: NotePolicy
  end

  # GET /notes/new
  def new
    authorize @book, policy_class: NotePolicy
    @note = @book.notes.build
  end

  # GET /notes/1/edit
  def edit
    authorize @book, policy_class: NotePolicy
  end

  # POST /notes or /notes.json
  def create
    authorize @book, policy_class: NotePolicy
    @note = @book.notes.build(note_params)
    if @note.save
      redirect_to book_notes_path(@book), notice: "La nota se creó correctamente."
    else
      render :new, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /notes/1 or /notes/1.json
  def update
    authorize @book, policy_class: NotePolicy
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

  def convert
    @converted_note = CommonMarker.render_html(@note.content)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def find_book
      @book = Book.find(params[:book_id])
    end
  
    def set_note
      @note = @book.notes.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:book_id, :title, :content)
    end
end
