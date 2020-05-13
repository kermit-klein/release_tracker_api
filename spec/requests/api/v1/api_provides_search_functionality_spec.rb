RSpec.describe Api::V1::SearchesController, type: :request do 

  describe "POST /api/v1/searches/" do 
    before do
      post '/api/v1/searches/', 
      params: {
        searchtext: "Will Smith"
      }
      end

    it "successfully returns name" do
      expect(JSON.parse(response.body)['name']).to eq "Will Smith"
    end 

    it "successfully returns related movie title" do
      expect(JSON.parse(response.body)['title']).to eq "Suicide Squad"
    end
  end
end