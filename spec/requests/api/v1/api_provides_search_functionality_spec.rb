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
    
    it "successfully returns first result's media type" do
      expect(response_json['result'][0]['media_type']).to eq 'person'
    end

    it 'for person, successfully returns name' do
      expect(response_json['result'][0]['name']).to eq 'Will Smith'
    end

    it "for person, successfully returns related movie title" do
      expect(response_json['result'][0]['known_for']['title']).to eq 'Suicide Squad'
    end
    
    it "for person, successfully returns id" do
      expect(response_json['result'][0]['id']).to eq 2888
    end

    it "for person, successfully returns role" do
      expect(response_json['result'][0]['known_for']['role']).to eq 'Acting'
    end
    
    it "successfully returns third result's media type" do
      expect(response_json['result'][2]['media_type']).to eq 'movie'
    end

    it 'for movie, successfully returns title' do
      expect(response_json['result'][2]['title']).to eq 'The Will Smith - Music Video Collection'
    end

    it "for movie, successfully returns release date" do
      expect(response_json['result'][2]['release_date']).to eq '1999-12-07'
    end
    
    it "for movie, successfully returns id" do
      expect(response_json['result'][2]['id']).to eq 323930
    end

    it "for movie, successfully returns overview" do
      expect(response_json['result'][2]['overview']).to eq 'The Will Smith - Music Video Collection'
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
