class CreateListenings < ActiveRecord::Migration[7.1]
  def change
    create_table :listenings do |t|
      t.integer :available_beds
      t.integer :price
      t.text :description
      t.boolean :has_wifi
      t.text :welcome_message
      t.references :reservation, index: true
      t.references :city, index: true
      t.references :admin, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
