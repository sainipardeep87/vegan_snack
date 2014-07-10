# This migration comes from spree_hub_connector (originally 20131004143648)
class AddStoreNameToAuguryEnvironment < ActiveRecord::Migration
  def change
    add_column :augury_environments, :store_name, :string
  end
end
