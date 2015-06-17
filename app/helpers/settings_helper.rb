module SettingsHelper

  def display_site(user)
    if user.setting && user.setting.site
      user.setting.site.name
    else
      "None"
    end
  end

  def display_track(user)
    if user.setting && user.setting.track
      user.setting.track.name
    else
      "None"
    end
  end

  def just_display_site
    # debugger;1;1
    if current_user.setting && current_user.setting.site
      current_user.setting.site.name
    else
      "None"
    end
  end

  def just_display_track
    if current_user.setting && current_user.setting.track
      current_user.setting.track.name
    else
      "None"
    end
  end

end
