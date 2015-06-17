class TrackCalendarsController < ApplicationController
  # GET /track_calendars
  # GET /track_calendars.xml
  def index
    @track_calendars = TrackCalendar.all :order => :start

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @track_calendars }
    end
  end

  # GET /track_calendars/1
  # GET /track_calendars/1.xml
  def show
    @track_calendar = TrackCalendar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @track_calendar }
    end
  end

  # GET /track_calendars/new
  # GET /track_calendars/new.xml
  def new
    @track_calendar = TrackCalendar.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @track_calendar }
    end
  end

  # GET /track_calendars/1/edit
  def edit
    @track_calendar = TrackCalendar.find(params[:id])
  end

  # POST /track_calendars
  # POST /track_calendars.xml
  def create
    @track_calendar = TrackCalendar.new(params[:track_calendar])

    respond_to do |format|
      if @track_calendar.save
        flash[:notice] = 'TrackCalendar was successfully created.'
        format.html { redirect_to(track_calendars_url) }
        format.xml  { render :xml => @track_calendar, :status => :created, :location => @track_calendar }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @track_calendar.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /track_calendars/1
  # PUT /track_calendars/1.xml
  def update
    @track_calendar = TrackCalendar.find(params[:id])

    respond_to do |format|
      if @track_calendar.update_attributes(params[:track_calendar])
        flash[:notice] = 'TrackCalendar was successfully updated.'
        format.html { redirect_to(track_calendars_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @track_calendar.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /track_calendars/1
  # DELETE /track_calendars/1.xml
  def destroy
    @track_calendar = TrackCalendar.find(params[:id])
    @track_calendar.destroy

    respond_to do |format|
      format.html { redirect_to(track_calendars_url) }
      format.xml  { head :ok }
    end
  end
end
