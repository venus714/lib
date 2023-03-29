class ReadingsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @readings = current_user.readings
      render json: @readings
    end
  
    def create
      @reading = current_user.readings.new(reading_params)
      if @reading.save
        render json: @reading, status: :created
      else
        render json: @reading.errors, status: :unprocessable_entity
      end
    end
  
    def show
      @reading = current_user.readings.find(params[:id])
      render json: @reading
    end
  
    def update
      @reading = current_user.readings.find(params[:id])
      if @reading.update(reading_params)
        render json: @reading
      else
        render json: @reading.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @reading = current_user.readings.find(params[:id])
      @reading.destroy
      head :no_content
    end
  
    private
  
    def reading_params
      params.require(:reading).permit(:book_id)
    end
  end
  