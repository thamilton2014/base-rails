# app/controllers/status_events_controller.rb
class StatusEventsController < ApplicationController
  before_action :set_status_event, only: [:show, :update, :destroy]

  #
  # Example Auth Token
  #   eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE1MDM1ODgxMzJ9.aoMumHU7nqpzdbDX6999qh0FHkJPRCcbgTuTaixp1wA

  # GET /status_events
  def index
    @status_events = current_user.status_events
    json_response(@status_events)
  end

  # POST /status_events
  def create
    @status_event = current_user.status_events.create!(status_event_params)
    json_response(@status_event, :created)
  end

  # GET /status_events/:id
  def show
    json_response(@status_event)
  end

  # PUT /status_events/:id
  def update
    @status_event.update(status_event_params)
    head :no_content
  end

  # DELETE /status_events/:id
  def destroy
    @status_event.destroy
    head :no_content
  end

  private

  # Whitelist the parameters
  def status_event_params
    # params.permit(:payload, :sha, :state, :description, :target_url)
  end

  # Get the event based on the id.
  def set_status_event
    @status_event = StatusEvent.find(params[:id])
  end

end # => end StatusEventsController
