class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.integer :value
      t.integer :resource_id
      t.string :bills
      t.string :description
      t.date :date

      t.timestamps
    end
    add_index :donations, :resource_id
  end
end
