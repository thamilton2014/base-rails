class RemoveBeforeFromPushEvents < ActiveRecord::Migration[5.1]
  def change
    remove_column :push_events, :before, :string
  end
end
