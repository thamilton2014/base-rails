class CreateStatusEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :status_events do |t|
      t.string :sha
      t.string :state
      t.string :description
      t.string :target_url

      t.timestamps
    end
  end
end
