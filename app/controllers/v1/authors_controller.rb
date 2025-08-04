module V1
  class AuthorsController < ApplicationController
    def index
      authors = AuthorPresenter.present(Author.all)

      render json: { data: authors }.to_json
    end

    def show
      include_books = ActiveModel::Type::Boolean.new.cast(params[:include_books])
      attributes_to_exclude = include_books ? [] : [ :books ]

      render json: { data: AuthorPresenter.present(author, attributes_to_exclude: attributes_to_exclude) }.to_json
    end

    def create
      author = Author.new(author_params)

      if author.save
        render json: { data: AuthorPresenter.present(author) }, status: :created
      else
        render json: { errors: author.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if author.update(author_params)
        render json: { data: AuthorPresenter.present(author) }
      else
        render json: { errors: author.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      author.destroy
      head :no_content
    end

    private

    def author
      @author ||= Author.find(params[:id])
    end

    def author_params
      params.require(:author).permit(:first_name, :last_name, books_attributes: %i[title])
    end
  end
end
