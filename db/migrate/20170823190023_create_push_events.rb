class CreatePushEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :push_events do |t|
      t.string :ref
      t.string :head
      t.string :before
      t.integer :size
      t.integer :distinct_size

      t.timestamps
    end
  end
end
