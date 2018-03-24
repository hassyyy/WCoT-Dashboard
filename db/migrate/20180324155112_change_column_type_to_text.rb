class ChangeColumnTypeToText < ActiveRecord::Migration
  def up
    change_column :donations, :description, :text
    change_column :meetings, :agenda, :text
    change_column :meetings, :minutes_of_meeting, :text
    change_column :resources, :address, :text
    change_column :resources, :other_details, :text
  end

  def down
    change_column :donations, :description, :string
    change_column :meetings, :agenda, :string
    change_column :meetings, :minutes_of_meeting, :string
    change_column :resources, :address, :string
    change_column :other_details, :address, :string
  end
end
