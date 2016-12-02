class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :short_id, :null=>false
      t.integer :user_id, :null=>false
    end
  end
end
