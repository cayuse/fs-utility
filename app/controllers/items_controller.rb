class ItemsController < ApplicationController

  def index
    respond_to do |format|
      format.html do
        #@page = params[:page] || 1
        @items = Item.search (Riddle.escape params[:search]), :include => :prices,
          :page => params[:page], :per_page => 50
      end
      format.pdf do
        @items = Item.order(:itemtype_id).includes(:prices)
      end
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def edit
    @page = params[:page] || 1
    @item = Item.find(params[:id])
    #items = Item.all :limit => 3, :conditions=>["sort >= ?", (@item.sort - 1)]
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      @item.sort ||= @item.id
      @item.save
      @price = @item.prices.build
        @price.price= params[:item][:price][:price].to_f
        @price.cost= params[:item][:price][:cost].to_f
        @price.fmv= params[:item][:price][:fmv].to_f
        @date = Date.strptime(params[:item][:price][:start], "%m/%d/%Y")
        @price.start = @date.beginning_of_month
        @price.item = @item
        #@price.start = params[:item][:price][:start]
      if @price.save
        flash[:notice] = 'Item was successfully created.'
        redirect_to(@item)
      else
        @item.destroy
        flash[:error] = 'Item not created. You must enter Pricing Information for new items.'
        redirect_to(new_item_url)
      end
    else
      render :action => "new"
    end
  end

  def update

    @item = Item.find(params[:id])
    page = params[:page][:page] || 1
    params[:item][:sitetype_ids] ||= []
    if @item.update(item_params)
      if params[:price][:start].blank? || @item.update_price(params[:price])
      flash[:notice] = 'Item was successfully updated.'
      #redirect_to edit_item_path(@item.next)
      redirect_to(items_url)
      else
        flash[:error] = 'Item not updated. Check that expire date is after last start date. Or did you double click?'
        render :action => "edit"
      end
    else
      render :action => "edit"
    end
  end

  def expire
    @item  = Item.find(params[:item][:id])
    @price = Price.find(params[:price][:id])
    if !(params[:price][:expire].empty?)
      @expire = Date.parse(params[:price][:expire]).monday

      orders = Orderitem.where(item_id:  @item.id)
      @orderitems = orders.select{|i| i.weeklydfcorder.weeklyorderreq.week > @expire}
      if @orderitems.empty?
        #if price.save
        if @price.update(price_params)
          @item.itemlocs.clear
          flash[:notice] = "item was expired on #{@expire}."
          redirect_to(items_url)
        else
          flash[:error] = 'item could not be expired.'
          redirect_to(@item)
        end
      else
        #expire.html.erb
      end
    else
      flash[:error] = "Date must be specified to expire."
      redirect_to edit_item_path(item)
    end
  end

  def destroy
    @item = Item.find(params[:id])
    Price.destroy @item.prices.collect(&:id)

    @item.destroy

    redirect_to(items_url)
  end

  def reorder
    @items = Item.includes(:prices)
    @items.each do |item|
      item.expired? ? item.sort+= 9999999 : item.sort += (item.itemtype.id * 1000)
    end
    @items.sort! {|a,b| a.sort <=> b.sort}
  end

  def update_order
    new_index = params[:index]
    new_index.each_with_index{|entry,i| Item.update_all(["sort = ?", i], ["id = ?", entry])}
    @items = Item.all :order => :sort
    render :action => "reorder"
  end
  
  private

  def item_params
    params.require(:item).permit(:name, :units, :issue, :sort, :mon, :tue, :wed, :thu, :fri,
                                 :mfgname, :mfgcode, :ordercode, :itemtype_id,
                                 {:sitetype_ids => []},
                                 {:prices_attributes => [:price, :cost, :fmv, :start]} )
  end
  def price_params
    params.require(:price).permit(:expire)
  end

end
