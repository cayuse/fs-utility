class ConditionsController < ApplicationController
  before_action :set_condition, only: [:show, :edit, :update, :destroy]

  # GET /conditions
  # GET /conditions.json
  def index
    @conditions = Condition.all
  end

  # GET /conditions/1
  # GET /conditions/1.json
  def show
  end

  # GET /conditions/new
  def new
    @condition = Condition.new
  end

  # GET /conditions/1/edit
  def edit
  end

  # POST /conditions
  # POST /conditions.json
  def create
    @condition = Condition.new(condition_params)
    if @condition.save
      redirect_to conditions_url, notice: 'Condition was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /conditions/1
  # PATCH/PUT /conditions/1.json
  def update
    if @condition.update(condition_params)
      redirect_to conditions_url, notice: 'Condition was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /conditions/1
  # DELETE /conditions/1.json
  def destroy
    @condition.destroy
    redirect_to conditions_url, notice: 'Condition was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_condition
      @condition = Condition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def condition_params
      params.require(:condition).permit(:name, {:category_ids => []} )
    end
end
