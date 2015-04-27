class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery except: :home

  include HighVoltage::StaticPage

  # before_filter :authenticate
  layout :layout_for_page

  def home
    @show = "ssss"
  end

  def common
    location = Geocoder.search("Dhaka 1361")
    @hash = Gmaps4rails.build_markers(location) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.infowindow "hello!"
    end
    # raise @hash.inspect
  end

  def get_twitter_json
    @product = $twitter.home_timeline
    # authorize! :show, @product
    render json: @product
  end

  private

  def layout_for_page
    case params[:id]
      when 'common'
        'common'
      else
        'application'
    end
  end


end
