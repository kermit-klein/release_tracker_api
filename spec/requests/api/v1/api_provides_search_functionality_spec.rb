RSpec.describe Api::V1::SearchesController, type: :request do
  describe 'GET /api/v1/searches/ successfully' do
    before do
      get '/api/v1/searches/',
          params: {
            q: 'Will Smith'
          }
    end

    it 'should return a 200 response' do
      expect(response).to have_http_status 200
    end

    it 'successfully returns first results name' do
      expect(response_json['result'][0]['name']).to eq 'Will Smith'
    end

    it 'successfully returns first related movie title' do
      expect(response_json['result'][0]['known_for'][0]['original_title']).to eq 'Suicide Squad'
    end

    it 'successfully returns second results name' do
      expect(response_json['result'][12]['name']).to eq 'Willow Smith'
    end

    it 'successfully returns second related movie title' do
      expect(response_json['result'][12]['known_for'][0]['original_title']).to eq 'I Am Legend'
    end

    it 'successfully returns third results name' do
      expect(response_json['result'][5]['name']).to eq 'Will Rae Smith'
    end

    it 'successfully returns third related movie title' do
      expect(response_json['result'][5]['known_for'][0]['original_title']).to eq 'Narcopolis'
    end

    it 'successfully returns fourth results name' do
      expect(response_json['result'][19]['name']).to eq 'Willie Smith III'
    end

    it 'successfully returns fourth related movie title' do
      expect(response_json['result'][19]['known_for'][0]['original_title']).to eq 'Jesus Christ Superstar Live in Concert'
    end
  end

  describe 'GET /api/v1/searches/ unsuccessfully' do
    before do
      get '/api/v1/searches/',
          params: {
            q: ''
          }
    end

    it 'empty query should return a 422 response' do
      expect(response).to have_http_status 422
    end

    it 'empty query returns error message' do
      expect(response_json['result']['errors'][0]).to eq "query must be provided"
    end
  end
end
