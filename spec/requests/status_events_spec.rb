# app/requests/status_events_spec.rb
require 'rails_helper'

RSpec.describe 'Status Events API' do
  # Initialize the test data
  let(:user) { create(:user) }
  let!(:status_events) { create_list(:status_event, 10, created_by: user.id) }
  let(:status_event_id) { status_events.first.id }
  # Authorize request
  let(:headers) { valid_headers }

  describe 'GET /status_events' do
    before { get '/status_events', params: {}, headers: headers }

    it 'returns status events' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /status_events/:id
  describe 'GET /status_events/:id' do
    before { get "/status_events/#{status_event_id}", params: {}, headers: headers }

    context 'when the status event exists' do
      it 'returns the status event' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(status_event_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:status_event_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Status/)
      end
    end
  end

  # Test suite for POST /status_events
  describe 'POST /status_events' do
    # Valid payload
    let(:valid_attributes) { { sha: "9049f1265b7d61be4a8904a9a27120d2064dab3b", state: "success", description: "Example description", target_url: "http://www.google.com" }.to_json }

    context 'when the request is valid' do
      before { post '/status_events', params: valid_attributes, headers: headers }

      it 'creates a status event' do
        expect(json['sha']).to eq('9049f1265b7d61be4a8904a9a27120d2064dab3b')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  # Test suite for PUT /status_events/:id
  describe 'PUT /status_events/:id' do
    let(:valid_attributes) { { sha: "9049f1265b7d61be4a8904a9a27120d2064dab3b", state: "pending", description: "Example description", target_url: "http://www.google.com" }.to_json }

    context 'when the record exists' do
      before { put "/status_events/#{status_event_id}", params: valid_attributes, headers: headers }

      it 'updates the status event' do
        expect(response.body).to be_empty
      end

      it 'returns the status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /status_events/:id
  describe 'DELETE /status_events/:id' do
    before { delete "/status_events/#{status_event_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end # => end Status Events Api Tests