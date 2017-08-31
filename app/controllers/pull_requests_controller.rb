# app/controllers/pull_requests_controller.rb
class PullRequestsController < ApplicationController
  before_action :set_pull_request, only: [:show, :update, :destroy]

  # GET /pull_requests
  def index
    @pull_requests = current_user.pull_requests
    json_response(@pull_requests)
  end

  # POST /pull_requests
  def create
    @pull_request = current_user.pull_requests.create!(pull_request_params)
    @pull_request.execute(pull_request_head_params.to_json, pull_request_repo_params.to_json)
    json_response(@pull_request, :created)
  end

  # GET /pull_requests/:id
  def show
    json_response(@pull_request)
  end

  # PUT /pull_requests/:id
  def update
    @pull_request.update(pull_request_params)
    head :no_content
  end

  # DELETE /pull_requests/:id
  def destroy
    @pull_request.destroy
    head :no_content
  end

  private

  # Whitelist the pull request parameters
  def pull_request_params
    params.require(:pull_request).permit(:url, :id, :html_url, :diff_url, :patch_url, :issue_url, :number, :state, :locked, :title)
  end

  def pull_request_head_params
    params.require(:pull_request).require(:head).permit(:label, :ref, :sha)
  end

  def pull_request_repo_params
    params.require(:pull_request).require(:head).require(:repo).permit(:id, :name, :full_name, :html_url)
  end

  # Get the pull request event based on the id.
  def set_pull_request
    @pull_request = PullRequest.find(params[:id])
  end
end # => end PullRequestController
