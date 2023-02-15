class CreateCountries < ActiveRecord::Migration[6.1]
  def change
    create_table :countries do |t|
      t.string :name, null: false
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
