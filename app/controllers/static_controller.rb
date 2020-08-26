class StaticController < ApplicationController
  def home
    render json: { status: "FOLLOW THE WHITE RABBIT"}
  end
end