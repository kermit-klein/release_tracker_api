# frozen_string_literal: true

RSpec.describe Api::V1::SearchesController, type: :request do
  describe 'GET /api/v1/searches/' do
    before do
      get '/api/v1/searches/',
          params: {
            searchtext: 'Will Smith'
          }
    end

    it 'should return a 200 response' do
      expect(response).to have_http_status 200
    end

    it 'successfully returns first results name' do
      expect(JSON.parse(response.body)['result'][0]['name']).to eq 'Will Smith'
    end

    it 'successfully returns related movie title' do
      expect(JSON.parse(response.body)['result'][0]['known_for'][0]['original_title']).to eq 'Suicide Squad'
    end

    it 'successfully returns first results name' do
      expect(JSON.parse(response.body)['result'][12]['name']).to eq 'Willow Smith'
    end

    it 'successfully returns related movie title' do
      expect(JSON.parse(response.body)['result'][12]['known_for'][0]['original_title']).to eq 'I Am Legend'
    end

    it 'successfully returns first results name' do
      expect(JSON.parse(response.body)['result'][17]['name']).to eq 'Wilson Smith'
    end

    it 'successfully returns related movie title' do
      expect(JSON.parse(response.body)['result'][17]['known_for'][1]['original_title']).to eq 'Krisha'
    end

    it 'successfully returns first results name' do
      expect(JSON.parse(response.body)['result'][19]['name']).to eq 'Willie Smith III'
    end

    it 'successfully returns related movie title' do
      expect(JSON.parse(response.body)['result'][19]['known_for'][0]['original_title']).to eq 'Jesus Christ Superstar Live in Concert'
    end
  end
end
