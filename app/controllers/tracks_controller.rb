class TracksController < ApplicationController
  # GET /tracks
  def index
    @tracks = Track.all
  end

  # GET /tracks/1
  def show
    @track = Track.find(params[:id])
  end

  # GET /tracks/new
  def new
    @track = Track.new
  end

  # GET /tracks/1/edit
  def edit
    @track = Track.find(params[:id])
  end

  # POST /tracks
  def create
    @track = Track.new(params[:track])

    if @track.save
      flash[:notice] = 'Track was successfully created.'
      redirect_to(@track)
    else
      render :action => "new"
    end
  end

  # PUT /tracks/1
  def update
    @track = Track.find(params[:id])

    if @track.update_attributes(params[:track])
      flash[:notice] = 'Track was successfully updated.'
      redirect_to(@track)
    else
      render :action => "edit"
    end
  end


  # DELETE /tracks/1
  def destroy
    @track = Track.find(params[:id])
    @track.destroy
    redirect_to(tracks_url)
  end
  
end
