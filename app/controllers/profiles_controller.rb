class ProfilesController < ApplicationController
  def show
    @user = current_user
    @reviews = @user.reviews.includes(:sale)
    puts @user.address
    puts "$$$$$$$ hola"
    @markers = [
      {
        # lat: -73.99209,
        # lng: 40.68933,
        info_window_html: render_to_string(partial: "info_window", locals: {flat: @user.address}),
        marker_html: render_to_string(partial: "marker")
      }
    ]
    puts "$$$$$$$ hola"
    puts @markers
  end

  def proxy
    response = HTTP.get("https://api.mapbox.com#{request.fullpath}", params: { access_token: ENV['MAPBOX_API_KEY'] })
    render json: response.body, status: response.code
  end
end
