RSpec.describe Api::SearchesController, type: :request do 


describe "POST  /Api/searches/" do 
  before do
    post '/api/searches/', 
    params: {
      key_word: "Will Smith"
    }
    end

  it "successfully returns name" do
  expect(JSON.parse(response.body)['name']).to eq "Will Smith"
end 

  it "successfully returns title" do
    expect(JSON.parse(response.body)['title']).to eq "Suicide Squad"

end
end
end