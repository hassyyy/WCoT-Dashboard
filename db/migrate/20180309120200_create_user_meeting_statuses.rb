class CreateUserMeetingStatuses < ActiveRecord::Migration
  def change
    create_table :user_meeting_statuses do |t|
      t.integer :user_id
      t.integer :meeting_id
      t.string :status

      t.timestamps
    end
    add_index :user_meeting_statuses, [:user_id, :meeting_id]
  end
end
