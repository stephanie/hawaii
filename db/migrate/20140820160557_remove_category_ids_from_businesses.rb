class RemoveCategoryIdsFromBusinesses < ActiveRecord::Migration
  def up
    remove_column :businesses, :category_ids
  end

  def down
    add_column :businesses, :category_ids, :string
  end
end
