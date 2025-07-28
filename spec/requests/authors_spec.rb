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

  describe 'GET /api/v1/authors/:id' do
    let(:author) { create(:author) }

    before { get "/api/v1/authors/#{author.id}" }

    it 'gets HTTP status 200' do
      expect(response.status).to eq 200
    end

    it 'receives a json with the "data" root key' do
      expect(json_body['data']).to_not be nil
    end

    it 'receives the author details' do
      expect(json_body['data'].deep_symbolize_keys).to include(
        id: author.id,
        name: author.name
      )
    end
  end

  describe 'POST /api/v1/authors' do
    let(:author_params) { attributes_for(:author) }

    before { post '/api/v1/authors', params: { author: author_params } }

    it 'gets HTTP status 201' do
      expect(response.status).to eq 201
    end

    it 'receives a json with the "data" root key' do
      expect(json_body['data']).to_not be nil
    end

    it 'creates a new author' do
      expect(Author.last.name).to eq "#{author_params[:first_name]} #{author_params[:last_name]}"
    end
  end

  describe 'PATCH /api/v1/authors/:id' do
    let(:author) { create(:author, first_name: 'John', last_name: 'Doe') }
    let(:updated_params) { { first_name: 'Updated', last_name: 'Author' } }

    before { patch "/api/v1/authors/#{author.id}", params: { author: updated_params } }

    it 'gets HTTP status 200' do
      expect(response.status).to eq 200
    end

    it 'updates the author details' do
      expect(author.reload.first_name).to eq updated_params[:first_name]
      expect(author.reload.last_name).to eq updated_params[:last_name]
    end
  end

  describe 'DELETE /api/v1/authors/:id' do
    let(:author) { create(:author) }

    before { delete "/api/v1/authors/#{author.id}" }

    it 'gets HTTP status 204' do
      expect(response.status).to eq 204
    end

    it 'deletes the author' do
      expect(Author.exists?(author.id)).to be false
    end
  end
end
