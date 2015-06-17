class MonthlyinvreqsController < ApplicationController

  def index
    per_page = 10
    months = (Monthlyinvreq.order(month: :desc).select(:month).distinct).map &:month
    @months = months.paginate :per_page => per_page, :page => 1
    @monthlyinvreqs = Sitetype.sitetype_invreqs
    @sitetypes = @monthlyinvreqs.keys.sort
  end

  def show
    @monthlyinvreq = Monthlyinvreq.includes(:monthlyinvs).find(params[:id])
  end

  def new
    #{(weeklydfcorder.weeklyorderreq.week + day.days).strftime('%A, %B %d, %Y')}
    if params[:monthlyinvreq][:month] == ""
      flash[:error] = 'You Must Select a Site Type and Date to continue'
      return(render :action=>:start)
    end
    
    @sitetype = Sitetype.find(params[:monthlyinvreq][:sitetype_id])
    firstday = params[:monthlyinvreq][:month]
    @date = Date.strptime(firstday, "%m/%d/%Y").beginning_of_month
    #@date = Date.parse(params[:monthlyinvreq][:month]).beginning_of_month
    if @sitetype.monthlyinvreqs.collect{|t| t.month}.include?(@date)
        flash[:error] = 'Inventory Request Entered for that sitetype and month'
        return(render :action=>:start)
    end
  
    flash[:notice] = 'Complete form for Inventory Request'
    @monthlyinvreq = Monthlyinvreq.new
  end

  def edit
    @monthlyinvreq = Monthlyinvreq.find(params[:id])
  end

  def start
    @monthlyinvreq = Monthlyinvreq.new
  end

  def create
    if params[:monthlyinvreq][:month]
      firstday = params[:monthlyinvreq][:month]
      params[:monthlyinvreq][:month] = Date.strptime(firstday, "%Y-%m-%d")
    end
    if params[:monthlyinvreq][:start]
      firstday = params[:monthlyinvreq][:start]
      params[:monthlyinvreq][:start] = Date.strptime(firstday, "%m/%d/%Y")
    end
    if params[:monthlyinvreq][:due]
      firstday = params[:monthlyinvreq][:due]
      params[:monthlyinvreq][:due] = Date.strptime(firstday, "%m/%d/%Y")
    end
    
    @monthlyinvreq = Monthlyinvreq.new(monthlyinvreq_params)
#    @monthlyinvreq = Monthlyinvreq.new(params[:monthlyinvreq])

    if @monthlyinvreq.save
      flash[:notice] = 'Monthlyinvreq was successfully created.'
      redirect_to(@monthlyinvreq)
    else
      flash[:error] = 'Monthlyinvreq was not created.'
      redirect_to monthlyinvreqs_path
    end
  end

  def update
    @monthlyinvreq = Monthlyinvreq.find(params[:id])
    if params[:monthlyinvreq][:start]
      firstday = params[:monthlyinvreq][:start]
      params[:monthlyinvreq][:start] = Date.strptime(firstday, "%m/%d/%Y")
    end
    if params[:monthlyinvreq][:due]
      firstday = params[:monthlyinvreq][:due]
      params[:monthlyinvreq][:due] = Date.strptime(firstday, "%m/%d/%Y")
    end
    if @monthlyinvreq.update(monthlyinvreq_params)
      flash[:notice] = 'Monthlyinvreq was successfully updated.'
      redirect_to(@monthlyinvreq)
    else
      render :action => "edit"
    end
  end

  def destroy
    @monthlyinvreq = Monthlyinvreq.find(params[:id])
    @monthlyinvreq.destroy

    redirect_to(monthlyinvreqs_url)
  end
  
  def dispatch_pdf
    unless params[:sitetypes]
      flash[:error] = 'You must select at least one Site Type'
      return redirect_to(monthlyinvreqs_url)
    end
  
    @sitetypes = params[:sitetypes]
    firstday = params[:month][:month]
    @date = Date.strptime(firstday, "%Y-%m-%d")
  
    #@monthlyinvreqs = Monthlyinvreq.find_all_by_sitetype_id(@sitetypes, :include => :monthlyinvs, :conditions =>["month = ?", @date])
    @monthlyinvreqs = Monthlyinvreq.includes(:monthlyinvs).where(sitetype_id: @sitetypes).where(month: @date)
    prawnto :prawn => {:page_layout => :landscape }
    case params[:submit]
      when "District Recap"
        render :file => 'monthlyinvreqs/recap.pdf.prawn'
      else
        redirect_to(monthlyinvreqs_url)
    end
    
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
#    def set_schoolyear
#      @schoolyear = Schoolyear.find(params[:id])
#    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def monthlyinvreq_params
      params.require(:monthlyinvreq).permit(:month, :start, :due, :sitetype_id)
    end

end
