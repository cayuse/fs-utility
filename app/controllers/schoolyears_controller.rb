class SchoolyearsController < ApplicationController
  before_action :set_schoolyear, only: [:show, :edit, :update, :destroy]

  # GET /schoolyears
  # GET /schoolyears.json
  def index
    @schoolyears = Schoolyear.all
  end

  # GET /schoolyears/1
  # GET /schoolyears/1.json
  def show
  end

  # GET /schoolyears/new
  def new
    @schoolyear = Schoolyear.new
  end

  # GET /schoolyears/1/edit
  def edit
  end

  # POST /schoolyears
  # POST /schoolyears.json
  def create
    @schoolyear = Schoolyear.new(schoolyear_params)

    respond_to do |format|
      if @schoolyear.save
        format.html { redirect_to @schoolyear, notice: 'Schoolyear was successfully created.' }
        format.json { render :show, status: :created, location: @schoolyear }
      else
        format.html { render :new }
        format.json { render json: @schoolyear.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schoolyears/1
  # PATCH/PUT /schoolyears/1.json
  def update
    respond_to do |format|
      if @schoolyear.update(schoolyear_params)
        format.html { redirect_to @schoolyear, notice: 'Schoolyear was successfully updated.' }
        format.json { render :show, status: :ok, location: @schoolyear }
      else
        format.html { render :edit }
        format.json { render json: @schoolyear.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schoolyears/1
  # DELETE /schoolyears/1.json
  def destroy
    @schoolyear.destroy
    respond_to do |format|
      format.html { redirect_to schoolyears_url, notice: 'Schoolyear was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schoolyear
      @schoolyear = Schoolyear.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def schoolyear_params
      params.require(:schoolyear).permit(:name)
    end
end
