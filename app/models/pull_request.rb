# app/models/pull_request.rb
class PullRequest < ApplicationRecord
  # Model validations
  # TODO - need to figure out why 'locked' isn't working. {"message":"Validation failed: Locked can't be blank"}
  alias_attribute :id, :pr_id
  validates_presence_of :url, :pr_id, :html_url, :diff_url, :patch_url, :issue_url, :number, :state, :title

  def execute(head_params, repo_params)
    CloneJob.perform_later(head_params, repo_params)
  end

end # => end PullRequest
