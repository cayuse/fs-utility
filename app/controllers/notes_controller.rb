class NotesController < ApplicationController
  before_action :set_note, only: [:edit, :update, :destroy]

  def index
    @notes = Note.all
    @note = Note.new
  end
  def new
    @note = Note.new
  end 

  def create
    @note = Note.new(note_params)
    if @note.save
       flash[:notice] = "Successfully created post."
       @notes = @note.student.notes
     end
  end

  def update
    if @note.update(note_params)
      flash[:notice] = "Successfully updated post."
      @notes = Note.all
    end
  end

  def destroy
    @note.destroy
    flash[:notice] = "Successfully destroyed post."
    @notes = @note.student.notes
  end

  private
    def set_note
      @note = Note.find(params[:id])
    end

    def note_params
      params.require(:note).permit(:student_id, :entry)
    end
end
