class AddGuestsToApartments < ActiveRecord::Migration[7.1]
  def change
    add_column :apartments, :guests, :integer
  end
end
