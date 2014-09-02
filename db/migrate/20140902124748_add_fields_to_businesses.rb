class AddFieldsToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :region, :string
    add_column :businesses, :country, :string
    add_column :businesses, :tel, :string
    add_column :businesses, :fax, :string
    add_column :businesses, :website, :string
    add_column :businesses, :hours_display, :string
    add_column :businesses, :po_box, :string
    add_column :businesses, :post_town, :string
    add_column :businesses, :admin_region, :string
  end
end
