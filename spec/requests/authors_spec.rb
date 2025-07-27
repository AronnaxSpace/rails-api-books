describe 'Author', type: :request do
  before { create_list(:author, 3) }

  describe 'GET /api/v1/authors' do
    before { get '/api/v1/authors' }

    it 'gets HTTP status 200' do
      expect(response.status).to eq 200
    end

    it 'receives a json with the "data" root key' do
      expect(json_body['data']).to_not be nil
    end

    it 'receives all 3 authors' do
      expect(json_body['data'].size).to eq 3
    end
  end
end
