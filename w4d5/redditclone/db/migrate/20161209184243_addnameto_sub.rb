class AddnametoSub < ActiveRecord::Migration
  def change
    remove_column :subs, :title
    add_column :subs, :name, :string, null: false 
  end
end
