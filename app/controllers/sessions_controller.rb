class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user && user.password == params[:password]
      token = SecureRandom.hex(16)
      user.update(u_token: token)
      @post_user = Post.all.pluck(:title, :body)
      render json: { message: ' Login Successful', token: token, post: @post_user }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    if @current_user.present?
      @current_user.update(u_token: nil)
      render json: { message: 'Log out successfully' }
    else
      render json: { message: 'Please login again!!' }
    end
  end
end
