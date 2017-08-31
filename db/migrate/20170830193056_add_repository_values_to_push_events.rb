class AddRepositoryValuesToPushEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :push_events, :name, :string
    add_column :push_events, :full_name, :string
    add_column :push_events, :html_url, :string
    add_column :push_events, :url, :string
    add_column :push_events, :repo_id, :integer
  end
end
