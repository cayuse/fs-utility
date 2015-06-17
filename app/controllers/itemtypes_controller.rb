class ItemtypesController < ApplicationController

  def index
    @itemtypes = Itemtype.order(:id)
  end

  def show
    @itemtype = Itemtype.find(params[:id])
  end

  def new
    @itemtype = Itemtype.new
  end

  def edit
    @itemtype = Itemtype.find(params[:id])
  end

  def create
    @itemtype = Itemtype.new(params[:itemtype])

    if @itemtype.save
      flash[:notice] = 'Itemtype was successfully created.'
      redirect_to(@itemtype)
    else
      render :action => "new"
    end
  end

  def update
    @itemtype = Itemtype.find(params[:id])

    if @itemtype.update_attributes(params[:itemtype])
      flash[:notice] = 'Itemtypes was successfully updated.'
      redirect_to(itemtypes_url)
    else
      render :action => "edit"
    end
  end

  def destroy
    @itemtype = Itemtype.find(params[:id])
    @itemtype.destroy

    redirect_to(itemtypes_url)
  end
  
end
