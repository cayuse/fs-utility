class BidnamesController < ApplicationController
  # GET /bidnames
  # GET /bidnames.xml
  def index
    @bidnames = Bidname.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bidnames }
    end
  end

  # GET /bidnames/1
  # GET /bidnames/1.xml
  def show
    @bidname = Bidname.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xls {send_data @bidname.xls, :type => :xls, :filename => @bidname.name + ".xls"}
    end
  end

  # GET /bidnames/new
  # GET /bidnames/new.xml
  def new
    @bidname = Bidname.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bidname }
    end
  end

  # GET /bidnames/1/edit
  def edit
    @bidname = Bidname.find(params[:id])
  end

  # POST /bidnames
  # POST /bidnames.xml
  def create
    @bidname = Bidname.new(params[:bidname])

    respond_to do |format|
      if @bidname.save
        flash[:notice] = 'Bidname was successfully created.'
        format.html { redirect_to(@bidname) }
        format.xml  { render :xml => @bidname, :status => :created, :location => @bidname }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bidname.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bidnames/1
  # PUT /bidnames/1.xml
  def update
    @bidname = Bidname.find(params[:id])

    respond_to do |format|
      if @bidname.update_attributes(params[:bidname])
        flash[:notice] = 'Bidname was successfully updated.'
        format.html { redirect_to(@bidname) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bidname.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bidnames/1
  # DELETE /bidnames/1.xml
  def destroy
    @bidname = Bidname.find(params[:id])
    @bidname.destroy

    respond_to do |format|
      format.html { redirect_to(bidnames_url) }
      format.xml  { head :ok }
    end
  end

  def drop_company
    companybidname = Companybidname.find(params[:id])
    @bidname = companybidname.bidname
    companybidname.destroy

    respond_to do |format|
      format.html { redirect_to(@bidname) }
      format.xml  { head :ok }
    end
  end
end
