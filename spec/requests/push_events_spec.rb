# app/requests/push_events_spec.rb
require 'rails_helper'

RSpec.describe 'Push Events API' do
  # Initialize the test data
  let(:user) {create(:user)}
  let!(:push_events) {create_list(:push_event, 10, created_by: user.id)}
  let(:push_event_id) {push_events.first.id}
  # Authorize request
  let(:headers) {valid_headers}
  let(:valid_github_headers) {github_headers}
  let(:first_user_token) {token_generator(user.id)}

  # Test suite for GET /push_events
  describe 'GET /push_events' do
    before {get '/push_events', params: {}, headers: headers}

    it 'returns push events' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /push_events/:id
  describe 'GET /push_events/:id' do
    before {get "/push_events/#{push_event_id}", params: {}, headers: headers}

    context 'when the push event exists' do
      it 'returns the push event' do
        expect(json).not_to be_empty
        expect(json['id']).to eql(push_event_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for POST /push_events
  describe 'POST /push_events' do

    context 'when the push event request is valid' do
      before {post "/push_events?token=#{first_user_token}", params: { ref: "123abc", after: "123asd", repository: { name: "test123"} }.to_json, headers: valid_github_headers}

      it 'creates a push event' do
        expect(json['ref']).to eq('123abc')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  # Test suite for PUT /push_events/:id
  describe 'PUT /push_events/:id' do
    context 'when the push event record exists' do
      before {put "/push_events/#{push_event_id}", params: { ref: "qwe456", after: "123asdf", repository: { name: "test123"} }.to_json, headers: headers}

      it 'updates the status event' do
        expect(response.body).to be_empty
      end

      it 'returns the status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /push_event/:id' do
    before {delete "/push_events/#{push_event_id}", params: {}, headers: headers}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end # => end Push Events Api Tests