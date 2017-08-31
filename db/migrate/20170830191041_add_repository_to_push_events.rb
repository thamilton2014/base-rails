class AddRepositoryToPushEvents < ActiveRecord::Migration[5.1]
  def change
    add_reference :push_events, :repository, foreign_key: true
  end
end
