class CreateTrackCalendars < ActiveRecord::Migration
  def self.up
    create_table :track_calendars do |t|
      t.references :track
      t.date :start

      t.timestamps
    end
  end

  def self.down
    drop_table :track_calendars
  end
end
