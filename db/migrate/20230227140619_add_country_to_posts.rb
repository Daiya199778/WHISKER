class AddCountryToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :country, :integer
  end
end
