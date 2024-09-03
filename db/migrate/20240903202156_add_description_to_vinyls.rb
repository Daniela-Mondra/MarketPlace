class AddDescriptionToVinyls < ActiveRecord::Migration[7.1]
  def change
    add_column :vinyls, :description, :text
  end
end
