class ChangeAlbumsTable < ActiveRecord::Migration
  def change
    change_column :albums, :live, :boolean, :null => true
  end
end
