class RemoveModeFromContributions < ActiveRecord::Migration
  def up
    remove_column :contributions, :mode
  end

  def down
    add_column :contributions, :mode, :string
  end
end
