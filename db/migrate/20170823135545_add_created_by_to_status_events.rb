class AddCreatedByToStatusEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :status_events, :created_by, :string
  end
end
