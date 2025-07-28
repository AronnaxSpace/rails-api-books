module V1
  class AuthorsController < ApplicationController
    def index
      authors = AuthorPresenter.present(Author.all)

      render json: { data: authors }.to_json
    end

    def show
      render json: { data: AuthorPresenter.present(author) }
    end

    private

    def author
      @author ||= Author.find(params[:id])
    end
  end
end
