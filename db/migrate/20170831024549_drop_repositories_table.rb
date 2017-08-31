class DropRepositoriesTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :repositories
  end
end
