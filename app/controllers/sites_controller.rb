class SitesController < ApplicationController
  
  # GET /sites
  def index
    @sites = Site.all.order :name
  end

  # GET /sites/1
  def show
    @site = Site.find(params[:id])
  end

  # GET /sites/new
  def new
    @site = Site.new
  end

  # GET /sites/1/edit
  def edit
    @site = Site.find(params[:id])
  end

  # POST /sites
  def create
    @site = Site.new(params[:site])
    if @site.save
      flash[:notice] = 'Site was successfully created.'
      redirect_to(@site)
    else
      render :action => "new" 
    end
  end

  # PUT /sites/1
  def update
    params.permit!
    @site = Site.find(params[:id])
    
    if @site.update_attributes(params[:site])
      flash[:notice] = 'Site was successfully updated.'
      redirect_to(sites_url)
    else
      render :action => "edit"
    end
end

  # DELETE /sites/1

  def destroy
    @site = Site.find(params[:id])
    @site.destroy
    
    redirect_to(sites_url)
  end
end
