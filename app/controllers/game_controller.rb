class GameController < ApplicationController
  def index
  	if session[:round_id] == nil
  		redirect_to rounds_path
  	end
  end
end
