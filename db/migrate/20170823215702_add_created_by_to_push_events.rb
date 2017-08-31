class AddCreatedByToPushEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :push_events, :created_by, :string
  end
end
