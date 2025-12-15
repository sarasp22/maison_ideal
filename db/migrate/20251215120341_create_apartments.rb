class CreateApartments < ActiveRecord::Migration[7.1]
  def change
    create_table :apartments do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :address, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.references :host, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end

