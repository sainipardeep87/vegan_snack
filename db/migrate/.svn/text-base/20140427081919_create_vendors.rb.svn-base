class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :name
      t.string :email
      t.text :notes
      t.boolean :deleted, default: false
      t.timestamps
    end
  end
end
