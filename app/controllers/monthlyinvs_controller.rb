class MonthlyinvsController < ApplicationController

  def index
    if @site = current_user.setting.site
      @monthlyinvreqs = Monthlyinvreq.where(sitetype_id: @site.sitetype.id).order("month DESC")
      @monthlyinvs = Monthlyinv.includes(:monthlyinvreq).where(site: @site)
    else
      flash[:error] = 'No Site Selected. Please Select a Site prior to proceeding.'
      redirect_to(setting_url, :action=>'edit')
    end
  end

  def show
    @monthlyinv = Monthlyinv.includes(:monthlyinvitems, :items).find(params[:id])
    test_viewable(@monthlyinv)
  end

  def edit
    @monthlyinv = Monthlyinv.find(params[:id])
    test_writable(@monthlyinv)
    site = current_user.setting.site

    @storelocs = Storeloc.where(site_id: site.id).order(:number)
    @monthlyinv_hash = @monthlyinv.allitems_for_site(current_user.setting.site)
  end

  def create
    if @site = current_user.setting.site
      monthlyreq = params[:id]
      @monthlyinv = Monthlyinv.new( :attributes => { :site_id=>@site.id, :monthlyinvreq_id => monthlyreq } )
      if @monthlyinv.save
        flash[:notice] = 'Monthly Inventory was successfully created.'
        redirect_to(edit_monthlyinv_path(@monthlyinv))
      else
       #@monthlyinv = Monthlyinv.find :first, :conditions => [ "monthlyinvreq_id = ? AND site_id = ?", monthlyreq, @site.id ]
        @monthlyinv = Monthlyinv.where(monthlyinvreq_id: monthlyreq.id).where(site_id: @site.sitetype.id).first
        if @monthlyinv
          flash[:error] = "Monthly Inventory exists. Did you double click?"
          redirect_to(edit_monthlyinv_path(@monthlyinv))
        else
          flash[:error] = "You Don't have an inventory for this month, yet it couldn't save. Please Try Again"
          redirect_to monthlyinvs_url
        end
      end

    else
      flash[:error] = 'No Site Selected. Please Select a Site prior to proceeding.'
      redirect_to(setting_url, :action=>'edit')
    end
  end

  def update
    @monthlyinv = Monthlyinv.find(params[:id])
    test_writable(@monthlyinv)
    redir = params[:referred][:referred] ? params[:referred][:referred] : monthlyinvs_url
    if session[:clickcode]
      redirect_to(redir)
    else
      session[:clickcode] = true
      if @monthlyinv.update(monthlyinv_params)
        flash[:notice] = 'Monthlyinv was successfully updated.'

        redirect_to monthlyinvs_url
      else
        site = current_user.setting.site
        @storelocs = Storeloc.where(site_id: site.id).order(:number)
        @monthlyinv_hash = @monthlyinv.allitems_for_site(current_user.setting.site)
        render :action => "edit"
      end
    end
  end

  def destroy
    @monthlyinv = Monthlyinv.find(params[:id])
    test_writable(@monthlyinv)
    @monthlyinv.destroy

    redirect_to(monthlyinvs_url)
  end

  def test_viewable(monthlyinv)
    unless current_user.authorized_for_site?(@monthlyinv.site)
      flash[:error] = "You do not have access to update that inventory"
      return redirect_to monthlyinvs_url
    end
    return true
  end

  def test_writable(monthlyinv)
    unless monthlyinv.monthlyinvreq.due >= Date.today
      flash[:error] = "This inventory is past due.  Editing is Prohibited"
      return redirect_to monthlyinvs_url
    end
    test_viewable(monthlyinv)
  end

  private
    def monthlyinv_params
      params.require(:monthlyinv).permit({:monthlyinvitems_attributes => [:id, :price_id, :storeloc_id, :item_id, :qty]})
    end

end
