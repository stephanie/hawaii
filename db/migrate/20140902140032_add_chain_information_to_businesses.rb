class AddChainInformationToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :chain_name, :string
    add_column :businesses, :chain_id, :string
  end
end
