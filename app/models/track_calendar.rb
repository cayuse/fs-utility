class TrackCalendar < ActiveRecord::Base
  belongs_to :track
  
  def <=> (other)
    start <=> other.start
  end
end
