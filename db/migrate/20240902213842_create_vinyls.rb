class CreateVinyls < ActiveRecord::Migration[7.1]
  def change
    create_table :vinyls do |t|
      t.string :title
      t.string :artist
      t.string :genre
      t.integer :price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
