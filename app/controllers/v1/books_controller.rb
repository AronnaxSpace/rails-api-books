module V1
  class BooksController < ApplicationController
    def index
      books = BookPresenter.present(Book.includes(:author).all)

      render json: { data: books }
    end

    def show
      render json: { data: BookPresenter.present(book) }
    end

    def create
      book = Book.new(book_params)

      if book.save
        render json: { data: BookPresenter.present(book) }, status: :created
      else
        render json: { errors: book.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if book.update(book_params)
        render json: { data: BookPresenter.present(book) }
      else
        render json: { errors: book.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      book.destroy
      head :no_content
    end

    private

    def book
      @book ||= Book.includes(:author).find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :author_id)
    end
  end
end
