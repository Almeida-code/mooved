class CreateTrucks < ActiveRecord::Migration[7.1]
  def change
    create_table :trucks do |t|
      t.string :title
      t.integer :price
      t.text :description
      t.integer :postcode

      t.timestamps
    end
  end
end
