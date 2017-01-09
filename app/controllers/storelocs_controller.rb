class StorelocsController < ApplicationController

  def index
    if @site = current_user.setting.site
    @storelocs = Storeloc.site(current_user)
    else
      flash[:error] = 'No Site Selected. Please Select a Site prior to proceeding.'
      redirect_to(setting_url, :action=>'edit')
    end

    respond_to do |format|
      format.html #html
      format.js #java
    end

  end

  def setup
    params[:search] ||= Monthlyinvreq::VALID_ITEM_TYPES.first
    if @site = Setting.current_site(current_user)
      if params[:find]
        itms = Item.search "@(name,mfgname,mfgcode,ordercode) #{params[:find]}", :sort_by => :sort
        @items = (itms.select { |b| !b.expired? })
      end
      unless @items
        @storelocs = Storeloc.where(site_id: @site.id).order(:number)
        @items = []
        # changed to just give an empty list on load, no sense in pre-loading the entire list no one is going to use it
        #= Item.where(itemtype_id: params[:search]).includes(:sitetypes).order(:sort).where(:sitemizations => {:sitetype_id => @site.sitetype.id})
        @storeTemp = [].push @items
        @storelocs.each do |loc|
          @storeTemp.push loc.itemlocs.sort.map {|m| m.item}
        end
      end

    else
      flash[:error] = 'No Site Selected. Please Select a Site prior to proceeding.'
      redirect_to(setting_url, :action=>'edit')
    end

    respond_to do |format|
      format.html #html
      format.js
    end

  end

  # GET /storelocs/1
  # GET /storelocs/1.xml
  def show
    @storeloc = Storeloc.find params[:id]
  end

  # GET /storelocs/new
  # GET /storelocs/new.xml
  def new
    if @site = Setting.current_site(current_user)
      @storeloc = Storeloc.new
    else
      flash[:error] = 'No Site Selected. Please Select a Site prior to proceeding.'
      redirect_to(setting_url, :action=>'edit')
    end
  end

  # GET /storelocs/1/edit
  def edit
    @storeloc = Storeloc.includes([:itemlocs, :items]).where(id: params[:id]).first
  end

  # POST /storelocs
  # POST /storelocs.xml
  def create
    if @site = Setting.current_site(current_user)
    @storeloc = Storeloc.new(storeloc_params)
    @storeloc.site = @site
    else
      flash[:error] = 'No Site Selected. Please Select a Site prior to proceeding.'
      redirect_to(setting_url, :action=>'edit')
    end

    if @storeloc.save
      flash[:notice] = 'Storage Location was successfully created.'
      redirect_to storelocs_path
    else
      render :action => "new"
    end
  end

  def update_itemlocs
    #byebug;1;1
    @site = Setting.current_site(current_user)
    params[:index].delete "none"
    used_locs = params[:index].to_h.keys.map {|m| m.to_i}
    params[:index].to_h.keys.each do |key|
      storeloc = Storeloc.find key
      item_nums = params[:index][key].map {|m| m.to_i}
      storeloc.itemlocs.each do |itemloc|
        itemloc.destroy unless item_nums.include? itemloc.item_id
      end
      item_nums.each do |num|
        storeloc.itemlocs.create(:item_id => num) unless storeloc.itemlocs.any? {|d| d.item_id == num}
      end
    end
    loc_numbers = @site.storelocs.map {|m| m.id}
    unused = loc_numbers - used_locs
    unless unused.empty?
      clear_locs = Storeloc.find unused
      clear_locs.each do |clear|
        clear.itemlocs.each do |loc|
          loc.destroy
        end
      end
    end
    redirect_to "/storelocs/setup"
  end

  def update_order
    site = Setting.current_site(current_user)
    new_index = params[:index]
    test_item = Storeloc.find new_index.first

    if test_item.site_id == site.id
      new_index.each_with_index{|entry,i| Storeloc.update_all(["number = ?", i], ["id = ?", entry])}
      flash[:notice] = "Storage locations successfully reordered"
      redirect_to storelocs_path
    else
      flash[:error] = "These storage locations aren't at your site"
      redirect_to storelocs_path
    end
  end

  def update
    @storeloc = Storeloc.find(params[:id])
    new_index = params[:index] || []
    respond_to do |format|
      if @storeloc.update(storeloc_params)
        new_index.each_with_index{ |entry,i| Itemloc.where(id: entry).update_all(sort:i) }
        flash[:notice] = 'Storage Location was successfully updated.'
        format.html { redirect_to storelocs_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @storeloc.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /storelocs/1
  # DELETE /storelocs/1.xml
  def destroy
    @storeloc = Storeloc.find(params[:id])
    @storeloc.itemlocs.each do |loc|
      loc.destroy
    end

    @storeloc.destroy

    respond_to do |format|
      format.html { redirect_to(storelocs_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def storeloc_params
      params.require(:storeloc).permit(:name, :number)
  end
end
