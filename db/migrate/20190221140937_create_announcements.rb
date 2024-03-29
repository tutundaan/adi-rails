class CreateAnnouncements < ActiveRecord::Migration[5.2]
  def change
    create_table :announcements do |t|
      t.string :message
      t.date :due
      t.integer :color
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
