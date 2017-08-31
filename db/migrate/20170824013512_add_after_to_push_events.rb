class AddAfterToPushEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :push_events, :after, :string
  end
end
