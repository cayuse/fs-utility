module SitesHelper
  def display_manager(site)
    if site.user_id
      user = User.find_by_id(site.user_id)
    end
    if user
      user.fullname
    else
      "None"
    end
  end
  
  def display_sitetype(site)
    if site.sitetype_id
      sitetype = Sitetype.find_by_id(site.sitetype_id)
    end
    if sitetype
      sitetype.name
    else
      "None"
    end
  end
  
  def self.just_site_number
      if current_user.setting && current_user.setting.site
      return current_user.setting.site.number
    else
      return nil
    end
  end
  
  def self.just_track_code
      if current_user.setting && current_user.setting.track
      return current_user.setting.track.code
    else
      return nil
    end
  end
end
