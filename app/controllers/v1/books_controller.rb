module V1
  class BooksController < ApplicationController
    def index
      books = BookPresenter.present(Book.includes(:author).all)

      render json: { data: books }
    end

    def show
      render json: { data: BookPresenter.present(book) }
    end

    private

    def book
      @book ||= Book.includes(:author).find(params[:id])
    end
  end
end
