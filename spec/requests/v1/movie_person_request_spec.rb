require 'rails_helper'

RSpec.describe "MoviePeople", type: :request do
  let(:headers) {{ HTTP_ACCEPT: 'application/json'}}

  describe 'GET/api/v1/movie_person/ with content' do
    before do
      get '/api/v1/movie_person/31'
    end

    it 'returns a 200 http response' do
      expect(response).to have_http_status 200
    end

    it 'returns a list of recent and upcoming movies' do
      expect(response_json['movies'].length).to eq 4
    end

    it 'only lists recent or future films' do
      response_json['movies'].each do |movie|
        expect(movie['release_date'][0..2]).to eq "202"
      end
    end

    it 'each movie has a title included' do
      expect(response_json['movies'].first).to have_key('title')
    end

    it "each movie has the person's role included" do
      expect(response_json['movies'].first).to have_key('role')
    end

    it "each movie has the a poster link included" do
      expect(response_json['movies'].first).to have_key('image')
    end

    it "each movie has the a synopsis included" do
      expect(response_json['movies'].first).to have_key('description')
    end
  end

  describe 'GET/api/v1/movie_person/ no content' do
    before do
      get '/api/v1/movie_person/33'
    end

    it 'returns a 204 http response' do
      expect(response).to have_http_status 204
    end
  end
end
