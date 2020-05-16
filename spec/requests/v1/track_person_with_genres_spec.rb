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
      # headers = { HTTP_ACCEPT: "application/json" }.merge!(@user_header)
     post '/api/v1/user_selection/', params: { user: user.id, person_id: 31 }
     post '/api/v1/user_selection/', params: { user: user.id, person_id: 30 }
    end

    it 'returns a 200 http response' do
      expect(response).to have_http_status 200
    end
    it 'returns sucess message' do
      expect(response_json['message']).to eq 'Data was saved sucessfully'
    end

    it 'user can view its tracked persons' do
      get '/api/v1/user_selection/',params: { user_id: user.id }
      binding.pry
      expect(response_json['data']['movies']['genres'].second).to have_data('Action')
    end
  end
end