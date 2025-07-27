module V1
  class AuthorsController < ApplicationController
    def index
      authors = Author.all

      render json: { data: authors }.to_json
    end
  end
end
