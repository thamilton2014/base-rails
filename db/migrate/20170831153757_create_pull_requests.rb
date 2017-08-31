class CreatePullRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :pull_requests do |t|
      t.string :url
      t.integer :pr_id
      t.string :html_url
      t.string :diff_url
      t.string :patch_url
      t.string :issue_url
      t.integer :number
      t.string :state
      t.boolean :locked
      t.string :title
      t.timestamps
    end
  end
end
