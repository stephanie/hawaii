class CreateBusinessesCategories < ActiveRecord::Migration
  def change
    create_table :businesses_categories, :id => false do |t|
      t.belongs_to :business, index: true
      t.belongs_to :category, index: true
    end
  end
end
