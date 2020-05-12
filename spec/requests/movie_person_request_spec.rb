require 'rails_helper'

RSpec.describe "MoviePeople", type: :request do
  let(:headers) {{ HTTP_ACCEPT: 'application/json'}}
  let(:repsonse) {{ response: }}

  describe 'GET/api/v1/movie_person/' do
    before do
      get '/api/v1/movie_person/31'
      
      
    end
  end

end
