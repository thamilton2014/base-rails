class DropRepoIdFromPushEvents < ActiveRecord::Migration[5.1]
  def change
    remove_column :push_events, :repo_id, :integer
  end
end
