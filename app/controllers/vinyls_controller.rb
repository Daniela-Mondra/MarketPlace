class VinylsController < ApplicationController
  resources :vinyls

  def index
    @vinyls = Vinyl.all    
  end
end
