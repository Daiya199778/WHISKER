class AddWhiskeyTypeToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :whiskey_type, :integer
  end
end
