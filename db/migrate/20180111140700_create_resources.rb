class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name
      t.string :address
      t.string :contact_details
      t.string :other_details

      t.timestamps
    end
  end
end
