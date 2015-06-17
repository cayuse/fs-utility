class AccountsController < ApplicationController
  before_filter :authenticate_user!
  before_filter do 
    redirect_to "/" unless current_user && current_user.admin?
  end
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    #Riddle.escape can't handle a nil, but searchd currently uses "" as nil.
    params[:search] ||= ""
    @users = User.search Riddle.escape(params[:search]),
      :page => params[:page], :per_page => 50
  end


  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to accounts, notice: 'Account was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end
  
  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to accounts_path, notice: 'Account was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to accounts_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :name, :fullname, :role, :password, :site_ids =>[])
    end

end
