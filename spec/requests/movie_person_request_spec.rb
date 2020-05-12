require 'rails_helper'

RSpec.describe "MoviePeople", type: :request do
  let(:headers) {{ HTTP_ACCEPT: 'application/json'}}
  let(:repsonse) {{ response: '/spec/requests/support/movie_person_response_json.rb' }}

  describe 'GET/api/v1/movie_person/' do
    before do
      get '/api/v1/movie_person/31'      
    end

    it 'returns a response with all information on actor/director selected' do
      expect(response_json).to eq movie_person_response_json
    end

  end

end
