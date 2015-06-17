class WeeklydfcordersController < ApplicationController

  def index
    date = Date.today - 4.months
    if @site = Setting.current_site(current_user)
     #@weeklyorderreqs = Weeklyorderreq.find_all_by_sitetype_id(@site.sitetype.id, :conditions => ["week > ?", date], :order=>:week)
      @weeklyorderreqs = Weeklyorderreq.where("sitetype_id = ? AND week > ?", @site.sitetype.id, date).order(:week)
      @weeklydfcorders = Weeklydfcorder.where(site: @site)
    else
      flash[:error] = 'No Site Selected. Please Select a Site prior to proceeding.'
      redirect_to(setting_url, :action=>'edit')
    end
  end

  def show
    @user = current_user
    @weeklydfcorder = Weeklydfcorder.includes([:items, :site]).where(id: params[:id]).first
    unless @user.authorized_for_site?(@weeklydfcorder.site)
      flash[:error] = "You do not have access to view that order"
      return redirect_to weeklydfcorders_url
    end
    @data = @weeklydfcorder.orderitems.sort.collect{ |b| [b.item.name, b.monqty, b.tueqty, b.wedqty, b.thuqty, b.friqty]}
  end

  def new
    @weeklydfcorder = Weeklydfcorder.new
  end

  def edit
    @weeklydfcorder = Weeklydfcorder.includes([:items, :site]).where(id: params[:id]).first
    unless current_user.authorized_for_site?(@weeklydfcorder.site)
      flash[:error] = "You do not have access to edit that order"
      return redirect_to weeklydfcorders_url
    end
    @newitems = @weeklydfcorder.unused_items
  end

  def create
    if @site = Setting.current_site(current_user)
      orderreq = params[:id]
      @weeklydfcorder = @site.weeklydfcorders.build :attributes=>{ :weeklyorderreq_id => orderreq }
      if @weeklydfcorder.save
        flash[:notice] = "Weekly DFC Order was successfully created."
        redirect_to(edit_weeklydfcorder_path(@weeklydfcorder))
      else
        @weeklydfcorder = Weeklydfcorder.where(weeklyorderreq_id: orderreq).where(site_id: @site_id).first
        if @weeklydfcorder
          flash[:error] = "Weekly DFC Order exists. Did you double click?"
          redirect_to(edit_weeklydfcorder_path(@weeklydfcorder))
        else
          flash[:error] = "Something went terribly wrong. Please Try Again"
          redirect_to weeklydfcorders_url
        end
      end
      
    else
      flash[:error] = 'No Site Selected. Please Select a Site prior to proceeding.'
      redirect_to(setting_url, :action=>'edit')
    end
  end

  def update
    @weeklydfcorder = Weeklydfcorder.find(params[:id])
    unless current_user.authorized_for_site?(@weeklydfcorder.site)
      flash[:error] = "You do not have access to update that order"
      return redirect_to weeklydfcorders_url
    end
    #if @weeklydfcorder.update_attributes(params[:weeklydfcorder])
    if @weeklydfcorder.update(weeklydfcorder_params)
      flash[:notice] = 'Weeklydfcorder was successfully updated.'
      
      redir = params[:referred][:referred] ? params[:referred][:referred] : weeklydfcorders_url
      redirect_to(redir)
    else
      @newitems = @weeklydfcorder.unused_items
      render :action => "edit"
    end
  end

  def destroy
    @weeklydfcorder = Weeklydfcorder.find(params[:id])
    @weeklydfcorder.destroy

    redirect_to(weeklydfcorders_url)
  end

  private
    def weeklydfcorder_params
      params.require(:weeklydfcorder).permit({:orderitems_attributes => [:id, :item_id, :updated_by, :monqty, :tueqty, :wedqty, :thuqty, :friqty]})
    end


end
