class NationController < ApplicationController
  def list
    render json: Nation.where(lang: "vi")
  end
end
