class SiteSetting < ActiveRecord::Base
  belongs_to :schoolyear
  
  def self.current_year
    a = SiteSetting.first
    unless a
      a = SiteSetting.new
      a.schoolyear = Schoolyear.last
      a.save
    end
    return a.schoolyear
  end
end
