class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:register, :login]

  # GET /users/me
  def me
    render json: current_user
  end

  # POST /users/register
  def register
    user = User.new(user_params)
    if user.save
      render json: { message: 'User registered successfully' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /users/login
  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = JwtService.encode(user_id: user.id)
      render json: { access_token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  # POST /users/logout
  def logout
    render json: { message: 'User logged out successfully' }
  end

  # GET /users/:id/books
  def user_books
    user = User.find(params[:id])
    render json: user.books
  end

  # POST /users/me/read
  def mark_book_as_read
    reading = Reading.new(user_id: current_user.id, book_id: params[:book_id], read_date: params[:read_date])
    if reading.save
      render json: { message: 'Book marked as read successfully' }, status: :created
    else
      render json: { errors: reading.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end
end
