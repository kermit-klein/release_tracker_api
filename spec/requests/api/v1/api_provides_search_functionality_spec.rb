# frozen_string_literal: true

RSpec.describe Api::V1::SearchesController, type: :request do
  describe 'GET /api/v1/searches/' do
    before do
      get '/api/v1/searches/',
          params: {
            searchtext: 'Will Smith'
          }
    end

    it 'successfully returns name' do
      expect(JSON.parse(response.body)['name']).to eq 'Will Smith'
    end

    it 'should return a 200 response' do
      expect(response).to have_http_status 200
    end

    it 'successfully returns related movie title' do
      expect(JSON.parse(response.body)['title']).to eq 'Suicide Squad'
    end
  end
end
