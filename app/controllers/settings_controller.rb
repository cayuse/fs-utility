class SettingsController < ApplicationController
  
  def index
      redirect_to '/settings/edit'
  end
  
  def show
    redirect_to '/settings/edit'
  end
  
  def edit
    @setting = Setting.new_or_old_setting(current_user)
    @sites = Site.find(current_user.site_ids).sort_by{|s| s.name}
    @tracks = Track.all
  end
  
  def new
    @setting = Setting.new
  end
  
  def update
    params.permit!
    @setting = Setting.new_or_old_setting(current_user)
    if @setting.id
      if @setting.update_attributes(params[:setting])
        flash[:notice] = 'Settings were successfully updated.'
        redirect_to '/settings'
      else
        redirect_to '/settings'
      end
    else
      params.permit!
      params[:setting][:user_id] = current_user.id
      @setting = Setting.new(params[:setting])
      if @setting.save
        flash[:notice] = 'Settings were successfully created.'
        redirect_to '/settings/edit'
      else
        redirect_to '/settings/edit'
      end
    end
  end

  
  def settrack
    track = Track.find(params[:settings][:id])
    current_user.setting.track = track
    redirect_to('/settings')
  end
  
   private

  def setting_params
    params.require(:setting).permit(:track_id, :site_id)
  end
  
end
