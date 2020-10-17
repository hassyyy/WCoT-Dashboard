class AddInternalToResource < ActiveRecord::Migration
  def change
    add_column :resources, :internal, :boolean
  end
end
