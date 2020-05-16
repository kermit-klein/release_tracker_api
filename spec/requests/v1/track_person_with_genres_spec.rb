RSpec.describe User, type: :request do
  let(:headers) {{ HTTP_ACCEPT: 'application/json'}}
  let(:user) {create(:user)}
  # let(:credentials) { user.create_new_auth_token }

  describe 'POST /api/v1/user_selection/ with content' do
    before do
     @user = User.create(email: "test@testing.com", password: "password", password_confirmation: "password")
     get '/api/v1/movie_person/31'
      @movie = response_json
     post '/api/v1/user_selection/', params: { user: @user.id, movie: response_json }
    #  binding.pry
    end

    it 'returns a 200 http response' do
      expect(response).to have_http_status 200
    end
    it 'returns sucess message' do
      expect(response_json['message']).to eq 'Data was saved sucessfully'
    end
    it 'returns user id' do
      expect(response_json['data']['user_id']).to eq @user.id
    end
    # DO WE NEED A SERIALIZER TO MAKE THIS EASIER ????
    # it 'returns genre' do
    #   binding.pry
    #   expect(response_json['data']['data']['movies'][0]['genre']).to eq 'Action'
    # end
    it 'returns id of tracked person' do
      expect(response_json['data']['id']).to eq 31
    end
  end
end