class CreateCreditcards < ActiveRecord::Migration
  def change
    create_table :creditcards do |t|
      t.string :token
      t.integer :customer_id
      t.string :cc_part_1
      t.string :cc_part_2
      t.string :cc_type
      t.string :cc_holder_name
      t.string :expiration_month
      t.string :expiration_year
    end
  end
end
