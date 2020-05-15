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

    it 'should return at most 5 people' do
      expect(response_json['data'].count).to eq 5
    end
    
    it "successfully returns person's id" do
      expect(response_json['data'][0]['id']).to eq 2888
    end

    it "successfully returns person's name" do
      expect(response_json['data'][0]['name']).to eq 'Will Smith'
    end
    
    it "successfully returns path to person's picture" do
      expect(response_json['data'][0]['picture']).to eq '/eze9FO9VuryXLP0aF2cRqPCcibN.jpg'
    end

    it "successfully returns person's related movie title" do
      expect(response_json['data'][0]['known_for_movie']).to eq 'Suicide Squad'
    end

    it "successfully returns person's role, only acting or directing" do
      expect(response_json['data'][0]['known_for_role']).to eq 'Acting'
    end

    it "successfully returns person's role, only acting or directing" do
      expect(response_json['data'][1]['known_for_role']).to eq 'Acting'
    end

    it "successfully returns person's role, only acting or directing" do
      expect(response_json['data'][2]['known_for_role']).to eq 'Acting'
    end

    it "for person, successfully returns role, only acting or directing" do
      expect(response_json['data'][3]['known_for_role']).to eq 'Acting'
    end

    it "successfully returns person's role, only acting or directing" do
      expect(response_json['data'][4]['known_for_role']).to eq 'Directing'
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
      expect(response_json['error_message']).to eq "Query must be provided"
    end
  end

  describe 'GET /api/v1/searches/ without result' do
    before do
      get '/api/v1/searches/',
        params: {
          q: 'uuaaoo'
        }
    end
 
    it 'Should return 400' do
      expect(response).to have_http_status 400
    end
    
    it 'Should return an error message' do
      expect(response_json['error_message']).to eq "No results found"
    end
  end
end
