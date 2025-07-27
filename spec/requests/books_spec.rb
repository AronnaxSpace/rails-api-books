describe 'Books', type: :request do
  before { create_list(:book, 3) }

  describe 'GET /api/v1/books' do
    before { get '/api/v1/books' }

    it 'gets HTTP status 200' do
      expect(response.status).to eq 200
    end

    it 'receives a json with the "data" root key' do
      expect(json_body['data']).to_not be nil
    end

    it 'receives all 3 books' do
      expect(json_body['data'].size).to eq 3
    end
  end
end
