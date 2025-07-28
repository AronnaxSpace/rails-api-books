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

  describe 'GET /api/v1/books/:id' do
    let(:book) { create(:book, :with_author) }

    before { get "/api/v1/books/#{book.id}" }

    it 'gets HTTP status 200' do
      expect(response.status).to eq 200
    end

    it 'receives a json with the "data" root key' do
      expect(json_body['data']).to_not be nil
    end

    it 'receives the book details' do
      expect(json_body['data'].deep_symbolize_keys).to include(
        id: book.id,
        title: book.title,
        author: {
          id: book.author.id,
          name: book.author.name
        }
      )
    end
  end

  describe 'POST /api/v1/books' do
    let(:book_params) do
      {
        title: 'New Book Title',
        author_id: create(:author).id
      }
    end

    before { post '/api/v1/books', params: { book: book_params } }

    it 'gets HTTP status 201' do
      expect(response.status).to eq 201
    end

    it 'receives a json with the "data" root key' do
      expect(json_body['data']).to_not be nil
    end

    it 'creates a new book' do
      expect(json_body['data'].deep_symbolize_keys).to include(
        title: book_params[:title],
        author: {
          id: book_params[:author_id],
          name: Author.find(book_params[:author_id]).name
        }
      )
    end
  end

  describe 'PATCH /api/v1/books/:id' do
    let(:book) { create(:book, :with_author) }
    let(:new_title) { 'Updated Book Title' }
    let(:update_params) { { title: new_title } }

    before { put "/api/v1/books/#{book.id}", params: { book: update_params } }

    it 'gets HTTP status 200' do
      expect(response.status).to eq 200
    end

    it 'updates the book title' do
      expect(book.reload.title).to eq new_title
    end
  end

  describe 'DELETE /api/v1/books/:id' do
    let(:book) { create(:book) }

    before { delete "/api/v1/books/#{book.id}" }

    it 'gets HTTP status 204' do
      expect(response.status).to eq 204
    end

    it 'deletes the book' do
      expect(Book.exists?(book.id)).to be false
    end
  end
end
