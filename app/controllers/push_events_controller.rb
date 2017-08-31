# app/controllers/push_events_controller.rb
class PushEventsController < ApplicationController
  before_action :set_push_event, only: [:show, :update, :destroy]

  # GET /push_events
  def index
    @push_events = current_user.push_events
    json_response(@push_events)
  end

  # POST /push_events
  # TODO - make sure token is passed in here
  def create
    @push_event = current_user.push_events.create!(push_event_params)

    folder = request.headers['X-GitHub-Delivery']
    CloneJob.perform_later(folder, @push_event)

    json_response(@push_event, :created)
  end

  # GET /push_events/:id
  def show
    json_response(@push_event)
  end

  # PUT /push_events/:id
  def update
    @push_event.update(push_event_params)
    head :no_content
  end

  # DELETE /push_events/:id
  def destroy
    @push_event.destroy
    head :no_content
  end

  private

  # Description here
  def push_event_params
    data   = {
        ref:       params[:ref],
        after:     params[:after],
        name:      params[:repository][:name],
        full_name: params[:repository][:full_name],
        html_url:  params[:repository][:html_url],
        url:       params[:repository][:url]
    }
    params = ActionController::Parameters.new(data)
    params.permit(:ref, :after, :name, :full_name, :html_url, :url)
  end

  # Description here
  def set_push_event
    @push_event = PushEvent.find(params[:id])
  end

end # => end PushEventsController
