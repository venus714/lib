class AuthorsController < ApplicationController
    before_action :set_author, only: [:show, :update, :destroy]
  
    # GET /authors
    def index
      @authors = Author.all
      render json: @authors
    end
  
    # GET /authors/:id
    def show
      render json: @author
    end
  
    # POST /authors
    def create
      authorize! :create, Author
      @author = Author.new(author_params)
  
      if author.save
        render json: author, status: :created, location: author
      else
        render json: author.errors, status: :unprocessable_entity
      end
    end
  
    # PUT /authors/:id
    def update
      authorize! :update, Author
      if @author.update(author_params)
        render json: author
      else
        render json: author.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /authors/:id
    def destroy
      authorize! :destroy, Author
      author.destroy
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_author
        @author = Author.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def author_params
        params.require(:author).permit(:name, :email, :phone)
      end
  end
  