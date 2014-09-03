class ChangeHoursDisplayTypeInBusinesses < ActiveRecord::Migration
  def self.up
    change_column :businesses, :hours_display, :text
  end
 
  def self.down
    change_column :businesses, :hours_display, :string
  end
end
