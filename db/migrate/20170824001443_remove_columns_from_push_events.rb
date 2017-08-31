class RemoveColumnsFromPushEvents < ActiveRecord::Migration[5.1]
  def change
    remove_column :push_events, :head, :string
    remove_column :push_events, :size, :integer
    remove_column :push_events, :distinct_size, :integer
  end
end
