class WelcomeController < ApplicationController
  def index
    @id = params[:id]
  end
end
