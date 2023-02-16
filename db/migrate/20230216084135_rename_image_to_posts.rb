class RenameImageToPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :image, :post_image
  end
end
