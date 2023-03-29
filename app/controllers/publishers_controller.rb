class PublishersController < ApplicationController
    def index
      @publishers = Publisher.all
      render json: @publishers
    end
  
    def create
      @publisher = Publisher.new(publisher_params)
      if @publisher.save
        render json: @publisher, status: :created
      else
        render json: @publisher.errors, status: :unprocessable_entity
      end
    end
  
    def show
      @publisher = Publisher.find(params[:id])
      render json: @publisher
    end
  
    def update
      @publisher = Publisher.find(params[:id])
      if @publisher.update(publisher_params)
        render json: @publisher
      else
        render json: @publisher.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @publisher = Publisher.find(params[:id])
      @publisher.destroy
      head :no_content
    end
  
    private
  
    def publisher_params
      params.require(:publisher).permit(:name, :address, :phone)
    end
  end
  