class Api::ApplicationController < ActionController::API
  before_action :restrict_access
  respond_to :json

  private

  def restrict_access
    api_key = ApiKey.find_by_access_token(params[:access_token])
    head :unauthorized unless api_key
    @user = User.find(params[:author_id])
  end
end
