# This migration comes from spree_hub_connector (originally 20130617104539)
class CreateAuguryEnvironments < ActiveRecord::Migration
  def change
    create_table :augury_environments do |t|
      t.string :url
      t.string :user
      t.string :token
      t.string :store_id
      t.string :environment
    end
  end
end
