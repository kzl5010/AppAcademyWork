class RemoveNullFromBonus < ActiveRecord::Migration
  def change
    change_column :tracks, :bonus, :boolean, :null => true
  end
end
