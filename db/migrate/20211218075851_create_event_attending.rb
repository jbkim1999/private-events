class CreateEventAttending < ActiveRecord::Migration[6.1]
  def change
    create_table :event_attendings do |t|
      t.references :attendee, index: true, foreign_key: { to_table: :users }
      t.references :attended_event, index: true, foreign_key: { to_table: :events }
      t.timestamps
    end
  end
end

# https://stackoverflow.com/questions/13694654/specifying-column-name-in-a-references-migration
