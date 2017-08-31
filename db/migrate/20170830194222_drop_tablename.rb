class DropTablename < ActiveRecord::Migration[5.1]
  def change
    drop_table :repositories
    remove_reference :push_events, :repository, foreign_key: true
  end
end
