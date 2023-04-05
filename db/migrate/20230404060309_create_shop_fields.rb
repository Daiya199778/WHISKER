class CreateShopFields < ActiveRecord::Migration[6.1]
  def change
    create_table :shop_fields do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :address
      t.string :image

      t.timestamps
    end
  end
end
