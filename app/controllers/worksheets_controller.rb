class WorksheetsController < ApplicationController
    before_action :set_worksheet, only: [:show, :edit, :update, :destroy]
  # GET /worksheets
  # GET /worksheets.xml
  def index
    if params[:search]
      @worksheets = Worksheet.search params[:search],
        :order => "name ASC" , :page => params[:page], :per_page => 100
      @worksheets.sort!
      respond_to do |format|
        format.html
        format.xml { render :xml => @songs }
      end
    else
      @worksheets = Worksheet.order(:name)
    end
  end

  # GET /worksheets/1
  # GET /worksheets/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @worksheet }
    end
  end

  # GET /worksheets/new
  # GET /worksheets/new.xml
  def new
    @worksheet = Worksheet.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @worksheet }
    end
  end

  # GET /worksheets/1/edit
  def edit
  end

  # POST /worksheets
  # POST /worksheets.xml

  def create
    @worksheet = Worksheet.new(worksheet_params)
    unless @worksheet.sheet.path
      flash[:error] = 'You Must Supply a file'
      render :action => "new"
      return
    end
      if @worksheet.save
        newname = @worksheet.sheet.path.gsub("%20"," ")
        system "/bin/mv \"#{@worksheet.sheet.path}\" \"#{newname}\" "
        flash[:notice] = 'Worksheet was successfully created.'
        redirect_to(worksheets_path)
      else
        render :action => "new"
      end
  end

  # PUT /worksheets/1
  # PUT /worksheets/1.xml
  def update
    respond_to do |format|
      if @worksheet.update(worksheet_params)
        newname = @worksheet.sheet.path.gsub("%20"," ")
        system "/bin/mv \"#{@worksheet.sheet.path}\" \"#{newname}\" "
        flash[:notice] = 'Worksheet was successfully updated.'
        format.html { redirect_to(@worksheet) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @worksheet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /worksheets/1
  # DELETE /worksheets/1.xml
  def destroy
    @worksheet.destroy

    respond_to do |format|
      format.html { redirect_to(worksheets_url) }
      format.xml  { head :ok }
    end
  end

  private
  
      def set_worksheet
      @worksheet = Worksheet.find(params[:id])
    end

    def worksheet_params
      params.require(:worksheet).permit(:name, :description, :sheet)
    end



end
