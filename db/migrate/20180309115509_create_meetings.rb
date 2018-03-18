class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :title
      t.string :agenda
      t.string :date
      t.string :starts_at
      t.string :ends_at
      t.string :minutes_of_meeting

      t.timestamps
    end
  end
end
