class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.date :startdate
      t.date :enddate
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
