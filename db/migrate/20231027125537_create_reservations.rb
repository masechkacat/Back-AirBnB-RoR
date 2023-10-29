class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.references :listening, index: true
      t.references :guest, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
