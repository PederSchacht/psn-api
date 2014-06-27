class PsnController < ApplicationController
  def profile
    @profile = ApiRequest.get_profile(params[:user_id])
    render json: @profile
  end
  def trophies
    @trophies = ApiRequest.get_trophies(params[:user_id])
    render json: @trophies
  end
  def game
    @game = ApiRequest.get_trophies_by_game(params[:user_id], params[:game_id])
    render json: @game
  end
  def trophy
    @trophy = ApiRequest.get_trophy(params[:user_id], params[:game_id], params[:trophy_id])
    render json: @trophy
  end
end
