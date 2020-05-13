require 'rails_helper'

RSpec.describe "MoviePeople", type: :request do
  let(:headers) {{ HTTP_ACCEPT: 'application/json'}}

  describe 'GET/api/v1/movie_person/' do
    before do
      get '/api/v1/movie_person/31'      
    end

    it 'returns a list of recent and upcoming movies' do
      expect(response_json['cast'].length).to eq 4
    end

    it 'only lists recent or future films' do
      response_json['cast'].each do |movie|
        expect(movie['release_date'][0..2]).to eq "202"
      end
    end

    it 'returns a response with all information on actor/director selected' do
      expect(response_json['cast'].first['title']).to eq 'Greyhound'   
    end
  end
end
