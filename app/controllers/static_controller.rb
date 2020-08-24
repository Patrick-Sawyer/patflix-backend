class StaticController < ApplicationController
  def home
    render json: { status: "Is Working"}
  end
end