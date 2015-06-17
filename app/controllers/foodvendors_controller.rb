class FoodvendorsController < ApplicationController
  # GET /foodvendors
  # GET /foodvendors.xml
  def index
    @foodvendors = Foodvendor.order(:name).includes(:nutritionals)
    @nutritionals = Nutritional.order(:codenum).includes(:foodvendor)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @foodvendors }
    end
  end

  # GET /foodvendors/1
  # GET /foodvendors/1.xml
  def show
    @foodvendor = Foodvendor.includes(:nutritionals).find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @foodvendor }
    end
  end

  # GET /foodvendors/new
  # GET /foodvendors/new.xml
  def new
    @foodvendor = Foodvendor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @foodvendor }
    end
  end

  # GET /foodvendors/1/edit
  def edit
    @foodvendor = Foodvendor.find(params[:id])
  end

  # POST /foodvendors
  # POST /foodvendors.xml
  def create
    @foodvendor = Foodvendor.new(foodvendor_params)

    respond_to do |format|
      if @foodvendor.save
        flash[:notice] = 'Foodvendor was successfully created.'
        format.html { redirect_to(@foodvendor) }
        format.xml  { render :xml => @foodvendor, :status => :created, :location => @foodvendor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @foodvendor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /foodvendors/1
  # PUT /foodvendors/1.xml
  def update
    @foodvendor = Foodvendor.find(params[:id])

    respond_to do |format|
      if @foodvendor.update(foodvendor_params)
        flash[:notice] = 'Foodvendor was successfully updated.'
        format.html { redirect_to(@foodvendor) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @foodvendor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /foodvendors/1
  # DELETE /foodvendors/1.xml
#  def destroy
#    @foodvendor = Foodvendor.find(params[:id])
#    @foodvendor.destroy

#    respond_to do |format|
#      format.html { redirect_to(foodvendors_url) }
#      format.xml  { head :ok }
#    end
#  end
  private

    def foodvendor_params
      # It's mandatory to specify the nested attributes that should be whitelisted.
      # If you use `permit` with just the key that points to the nested attributes hash,
      # it will return an empty hash.
      params.require(:foodvendor).permit(:name, :address1, :address2, :city, :state, :zip, :contact, :phone, :fax, :email, :avatar)
    end
end
