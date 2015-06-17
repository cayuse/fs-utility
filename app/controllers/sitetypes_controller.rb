class SitetypesController < ApplicationController
  # GET /sitetypes
  # GET /sitetypes.xml
  def index
    @sitetypes = Sitetype.find(:all, :order=>:id)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sitetypes }
    end
  end

  # GET /sitetypes/1
  # GET /sitetypes/1.xml
  def show
    @sitetype = Sitetype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sitetype }
    end
  end

  # GET /sitetypes/new
  # GET /sitetypes/new.xml
  def new
    @sitetype = Sitetype.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sitetype }
    end
  end

  # GET /sitetypes/1/edit
  def edit
    @sitetype = Sitetype.find(params[:id])
  end

  # POST /sitetypes
  # POST /sitetypes.xml
  def create
    @sitetype = Sitetype.new(params[:sitetype])

    respond_to do |format|
      if @sitetype.save
        flash[:notice] = 'Sitetype was successfully created.'
        format.html { redirect_to(@sitetype) }
        format.xml  { render :xml => @sitetype, :status => :created, :location => @sitetype }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sitetype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sitetypes/1
  # PUT /sitetypes/1.xml
  def update
    @sitetype = Sitetype.find(params[:id])

    respond_to do |format|
      if @sitetype.update_attributes(params[:sitetype])
        flash[:notice] = 'Sitetype was successfully updated.'
        format.html { redirect_to(@sitetype) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sitetype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sitetypes/1
  # DELETE /sitetypes/1.xml
  def destroy
    @sitetype = Sitetype.find(params[:id])
    @sitetype.destroy

    respond_to do |format|
      format.html { redirect_to(sitetypes_url) }
      format.xml  { head :ok }
    end
  end
end
