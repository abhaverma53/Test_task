class ApplicationController < ActionController::API
  before_action :authenticate_user, except: [:create]

  private

  def authenticate_user
    token = request.headers['Authorization']
    if token.present?
      @current_user = User.find_by(u_token: token)
      if @current_user.present?
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  end
end
