class AddYelpAvatarToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :yelp_avatar, :string
  end
end
