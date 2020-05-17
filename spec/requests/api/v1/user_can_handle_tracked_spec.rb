# frozen_string_literal: true

RSpec.describe UserSelection, type: :request do
  let(:user) { create(:user, email: 'alredyTaken@mail.com') }
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'POST /api/v1/user_selection/ with content' do
    before do
      post '/api/v1/user_selection', params: { person_id: 31 }, headers: headers
      post '/api/v1/user_selection', params: { person_id: 30 }, headers: headers
    end

    it 'returns a 200 http response' do
      expect(response).to have_http_status 200
    end
    it 'returns list of the users tracked people' do
      expect(response_json['user_selection'].length).to eq 2
    end

    it 'user can view its tracked persons' do
      get '/api/v1/user_selection', headers: headers
      expect(response_json['user_selection'].last['id']).to eq 30
    end

    it 'each person has a name' do
      get '/api/v1/user_selection', headers: headers
      expect(response_json['user_selection'].first['name']).to eq 'Tom Hanks'
    end

    it 'people not in the cached list of names also gets a name' do
      post '/api/v1/user_selection', params: { person_id: 2328 }, headers: headers
      expect(response_json['user_selection'].last['name']).to eq 'Manuel Corrales'
    end
  end
end
