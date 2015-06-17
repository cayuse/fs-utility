class AllergensController < ApplicationController
  # GET /allergens
  # GET /allergens.xml
  def index
    @allergens = Allergen.order(:sort)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @allergens }
    end
  end

  # GET /allergens/1
  # GET /allergens/1.xml
  def show
    @allergen = Allergen.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @allergen }
    end
  end

  # GET /allergens/new
  # GET /allergens/new.xml
  def new
    @allergen = Allergen.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @allergen }
    end
  end

  # GET /allergens/1/edit
  def edit
    @allergen = Allergen.find(params[:id])
  end

  # POST /allergens
  # POST /allergens.xml
  def create
    @allergen = Allergen.new(params[:allergen])
    if @allergen.save
      flash[:notice] = 'Allergen was successfully created.'
      redirect_to allergens_url
    else
      render :action => "new"
    end
  end

  # PUT /allergens/1
  # PUT /allergens/1.xml
  def update
    @allergen = Allergen.find(params[:id])

      if @allergen.update_attributes(params[:allergen])
          flash[:notice] = 'Allergen was successfully udated.'
          redirect_to allergens_url
        else
          render :action => "edit"
    end
  end

  # DELETE /allergens/1
  # DELETE /allergens/1.xml
  def destroy
    @allergen = Allergen.find(params[:id])
    @allergen.destroy

    respond_to do |format|
      format.html { redirect_to(allergens_url) }
      format.xml  { head :ok }
    end
  end

  def update_order
    new_index = params[:index]
    new_index.each_with_index{|entry,i| Allergen.update_all(["sort = ?", i], ["id = ?", entry])}
    redirect_to allergens_url
  end
  
  
end
