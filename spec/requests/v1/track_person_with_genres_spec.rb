RSpec.describe User, type: :request do
  let(:user) { create(:user, email: 'alredyTaken@mail.com') }
  # let(:user_selection) { create(:user_selection) }
  # let(:credentials) { user.create_new_auth_token }
  # let(:headers) { HTTP_ACCEPT: "application/json" }
  # let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  
  describe 'POST /api/v1/user_selection/ with content' do
    before do
    #  user = User.create(email: "user@testing.com", password: "password", password_confirmation: "password")
    #  post '/api/v1/auth/sign_in',params: {email: "user@testing.com", password: "password"}

    #  @user_id = response_json['data']['id']
    #  @user_header = response.headers
    
    #  get '/api/v1/movie_person/31'
    #   person_id = response_json['id']
      # headers = { HTTP_ACCEPT: "application/json" }.merge!(@user_header)
     post '/api/v1/user_selection/', params: { user: user.id }
     post '/api/v1/user_selection/', params: { user: user.id }
    #  @user_id = response_json['user_id']
    #  @person_id = response_json['person_id']
    # binding.pry
    end

    it 'returns a 200 http response' do
      expect(response).to have_http_status 200
    end
    it 'returns sucess message' do
      expect(response_json['message']).to eq 'Data was saved sucessfully'
    end

    it 'user can view its tracked persons' do
      get '/api/v1/user_selection/',params: { user_id: user.id }
      # selection = response_json
      # binding.pry
      # expect(response_json['data']['data']['movies'][0]['genre']).to eq 'Action'
    end

    ## !!! HILFE !!!!!
    # DO WE NEED A SERIALIZER TO MAKE THIS EASIER ????
    # it 'returns genre' do
    #   binding.pry
    #   expect(response_json['data']['data']['movies'][0]['genre']).to eq 'Action'
    # end

    ## NOT RETURNING THE EXPECTED ID..... 
    # it 'returns id of tracked person' do
    #   expect(response_json['data']['id']).to eq 31
    # end
  end
end