# app/controllers/api/v1/me_controller.rb
class Api::V1::MeController < ApplicationController
  before_action -> { doorkeeper_authorize! }

  def show
    render json: { user: "Lalit", email: "lalit@example.com" }
  end
end
