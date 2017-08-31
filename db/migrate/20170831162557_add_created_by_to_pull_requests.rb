class AddCreatedByToPullRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :pull_requests, :created_by, :string
  end
end
