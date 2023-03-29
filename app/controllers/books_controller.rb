class BooksController < ApplicationController
    before_action :authenticate_user!, only: [:create, :update, :destroy]
  
    def index
      @books = Book.all
      render json: @books
    end
  
    def create
      if current_user.role != "admin"
        render json: { error: "You do not have permission to perform this action" }, status: :unauthorized
      else
        @book = Book.new(book_params)
        if @book.save
          render json: @book, status: :created
        else
          render json: { error: "Failed to create book" }, status: :unprocessable_entity
        end
      end
    end
  
    def show
      @book = Book.find(params[:id])
      render json: @book
    end
  
    def update
      @book = Book.find(params[:id])
      if current_user.role != "admin"
        render json: { error: "You do not have permission to perform this action" }, status: :unauthorized
      elsif @book.update(book_params)
        render json: @book
      else
        render json: { error: "Failed to update book" }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @book = Book.find(params[:id])
      if current_user.role != "admin"
        render json: { error: "You do not have permission to perform this action" }, status: :unauthorized
      elsif @book.destroy
        head :no_content
      else
        render json: { error: "Failed to delete book" }, status: :unprocessable_entity
      end
    end
  
    private
  
    def book_params
      params.require(:book).permit(:title, :author_id, :publisher_id)
    end
  end
  