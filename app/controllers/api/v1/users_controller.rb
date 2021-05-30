class Api::V1::UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def authentication
    if user_signed_in?
      if current_user.picture?
        picture = current_user.picture.url
      else
        picture = nil
      end
      user = { auth: true, id: current_user.id, picture: picture }
    else
      user = { auth: false, id: nil, picture: nil }
    end
    render json: user
  end
end
