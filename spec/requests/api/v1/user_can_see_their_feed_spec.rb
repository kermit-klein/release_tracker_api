RSpec.describe Api::V1::MoviePersonController do
  let(:user) {create(:user)}
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe "GET /api/v1/movie_person with content" do
    before do
      user.user_selections.create(person_id: 31)
      user.user_selections.create(person_id: 572541)
      get '/api/v1/movie_person', headers: headers
    end

    it "shows movie from first person" do
      expect(response_json['data']['movies'].find{|movie| movie['title'] == "Greyhound"}['title']).to eq "Greyhound"
    end

    it "shows movie from second person" do
      expect(response_json['data']['movies'].find{|movie| movie['title'] == "Viena and the Fantomes"}['title']).to eq "Viena and the Fantomes"
    end

    it "shows a movie with both actors only once" do
      expect(response_json['data']['movies'].select {|movie| movie['title'] == "BIOS"}.length).to eq 1
    end

    it "lists both people as tracked in the movie with both actors" do
      expect(response_json['data']['movies'].select {|movie| movie['title'] == "BIOS"}.first['name']).to eq "Tom Hanks, Caleb Landry Jones"
    end
  end

  describe "GET /api/v1/movie_person without content" do
    before do
      user.user_selections.create(person_id: 33)
      user.user_selections.create(person_id: 88888)
      get '/api/v1/movie_person', headers: headers
    end

    it "responds with an error" do
      expect(response).to have_http_status 400
    end

    it "has an error message" do
      expect(response_json['error']).to eq "No upcoming releases"
    end
  end

  describe "user is not tracking anytinh" do
    before do
      get '/api/v1/movie_person', headers: headers
    end

    it "responds with an error" do
      expect(response).to have_http_status 400
    end

    it "has an error message" do
      expect(response_json['error']).to eq "You are not tracking anything"
    end
  end
end

