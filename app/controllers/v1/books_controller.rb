module V1
  class BooksController < ApplicationController
    def index
      books = Book.all

      render json: { data: books }.to_json
    end
  end
end
