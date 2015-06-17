class MonthlyinvitemsController < ApplicationController

  def index
    @monthlyinvitems = Monthlyinvitem.all
  end

  def show
    @monthlyinvitem = Monthlyinvitem.find(params[:id])
  end

  def new
    @monthlyinvitem = Monthlyinvitem.new
  end

  def edit
    @monthlyinvitem = Monthlyinvitem.find(params[:id])
  end

  def create
    @monthlyinvitem = Monthlyinvitem.new(params[:monthlyinvitem])

    if @monthlyinvitem.save
      flash[:notice] = 'Monthlyinvitem was successfully created.'
      redirect_to(@monthlyinvitem)
    else
      render :action => "new"
    end
  end

  def update
    @monthlyinvitem = Monthlyinvitem.find(params[:id])

    if @monthlyinvitem.update_attributes(params[:monthlyinvitem])
      flash[:notice] = 'Monthlyinvitem was successfully updated.'
      redirect_to(@monthlyinvitem)
    else
      render :action => "edit"
    end
  end

  def destroy
    @monthlyinvitem = Monthlyinvitem.find(params[:id])
    @monthlyinvitem.destroy

    redirect_to(monthlyinvitems_url)
  end
  
end
