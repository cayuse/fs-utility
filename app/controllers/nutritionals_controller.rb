class NutritionalsController < ApplicationController
  # GET /nutritionals
  # GET /nutritionals.xml
  def index
    if params[:search]
      @nutritionals = Nutritional.search params[:search],
      :include => :foodvendor, :order => "codenum ASC" , :page => params[:page], :per_page => 100
      @nutritionals.sort!
      respond_to do |format|
        format.html
        format.xml { render :xml => @songs }
      end
    else
      @nutritionals = Nutritional.all :order => 'codenum ASC'
    end

  end

  # GET /nutritionals/1
  # GET /nutritionals/1.xml
  def show
    @nutritional = Nutritional.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @nutritional }
    end
  end

  # GET /nutritionals/new
  # GET /nutritionals/new.xml
  def new
    @nutritional = Nutritional.new
    @nutritional.foodvendor_id = params[:vendor].to_i

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @nutritional }
    end
  end

  # GET /nutritionals/1/edit
  def edit
    @nutritional = Nutritional.find(params[:id])
  end

  # POST /nutritionals
  # POST /nutritionals.xml
  def create
    @nutritional = Nutritional.new(params[:nutritional])
      if @nutritional.save
        newname = @nutritional.attachment.path.gsub("%20"," ")
        system "/bin/mv \"#{@nutritional.attachment.path}\" \"#{newname}\" "

#        randfile = "/tmp/ocr" + ActiveSupport::SecureRandom.hex(8)
#        system "/usr/foodservices/bin/pdf2tif \"#{@nutritional.attachment.path}\" #{randfile}.tif"
#        system "/usr/local/bin/tesseract #{randfile}.tif #{randfile}"
#        @nutritional.search = ""
#        file = File.new("#{randfile}.txt", "r")
#        while c = file.gets
#          @nutritional.search += "#{c.downcase}"
#        end

        flash[:notice] = 'Item was successfully Added.'
        redirect_to(@nutritional.foodvendor)
        #render :action => "edit"
      else
        render :action => "new"
      end

  end

  # PUT /nutritionals/1
  # PUT /nutritionals/1.xml
  def update
    @nutritional = Nutritional.find(params[:id])

    respond_to do |format|
      if @nutritional.update_attributes(params[:nutritional])
        newname = @nutritional.attachment.path.gsub("%20"," ")
        system "/bin/mv \"#{@nutritional.attachment.path}\" \"#{newname}\" "
        flash[:notice] = 'Nutritional was successfully updated.'
        format.html { redirect_to(@nutritional.foodvendor) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @nutritional.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /nutritionals/1
  # DELETE /nutritionals/1.xml
  def destroy
    @nutritional = Nutritional.find(params[:id])
    foodvendor = @nutritional.foodvendor
    @nutritional.destroy

    respond_to do |format|
      format.html { redirect_to(foodvendor) }
      format.xml  { head :ok }
    end
  end
end
