class AddRepoReference < ActiveRecord::Migration[5.1]
  def change
    add_reference :repositories, :push_events, foreign_key: true
  end
end
