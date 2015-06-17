class DietdocumentsController < ApplicationController
  before_action :set_dietdocument, only: [:edit, :update, :destroy]

  def new
    @dietdocument = Dietdocument.new(:student_id => params[:student_id])
  end

  def edit
  end

  def create
    @dietdocument = Dietdocument.new(dietdocument_params)
    @dietdocument.save
    redirect_to student_path(@dietdocument.student)
  end

  def update
    @dietdocument.update(dietdocument_params)
    redirect_to student_path(@dietdocument.student)
  end

  def destroy
    @dietdocument.destroy
    redirect_to student_path(@dietdocument.student)
  end

  private
    def set_dietdocument
      @dietdocument = Dietdocument.find(params[:id])
    end

    def dietdocument_params
      params.require(:dietdocument).permit(:student_id, :name, :description, :dietscan)
    end
end
