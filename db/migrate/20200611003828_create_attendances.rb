class CreateAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :attendances do |t|
      t.string :name
      t.string :lastname
      t.string :origin
      t.integer :status
      t.string :responsible
      t.string :telephone
      t.string :email
      t.string :subject
      t.string :note
      t.string :channel

      t.timestamps
    end
  end
end
