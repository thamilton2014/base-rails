class DropRepoReference < ActiveRecord::Migration[5.1]
  def change
    remove_reference :push_events, :repositories, foreign_key: true
    remove_reference :push_events, :repository, foreign_key: true
  end
end
