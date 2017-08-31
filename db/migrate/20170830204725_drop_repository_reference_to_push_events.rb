class DropRepositoryReferenceToPushEvents < ActiveRecord::Migration[5.1]
  def change
    remove_reference :repositories, :push_events, foreign_key: true
    remove_reference :repository, :push_events, foreign_key: true
  end
end
