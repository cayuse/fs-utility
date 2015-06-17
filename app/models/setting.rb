class Setting < ActiveRecord::Base
  belongs_to :user
  belongs_to :site
  belongs_to :track
    
  def self.new_or_old_setting(user)
    "Class method"
    if user.setting
      setting = Setting.find_by_user_id(user)
    else
      setting = Setting.new
    end
      return setting
  end
  
  def self.just_site_number(user)
      if user.setting && user.setting.site
      return user.setting.site.number
    else
      return nil
    end
  end
  
  def self.just_track_code(user)
      if user.setting && user.setting.track
      return user.setting.track.code
    else
      return nil
    end
  end

  def self.just_site_id(user)
      if user.setting && user.setting.site
      return user.setting.site.id
    else
      return nil
    end
  end
  
  def self.current_site(user)
    if user.setting && user.setting.site
      return user.setting.site
    else
      return nil
    end
  end
  
end
