class AddTimeStampsToVisit < ActiveRecord::Migration
  def change
    add_column(:visits, :created_at, :datetime)
    add_column(:visits, :updated_at, :datetime)
    add_index(:visits, :short_id)
    add_index(:visits, :user_id)
  end
end
