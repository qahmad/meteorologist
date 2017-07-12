require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    coordinates = JSON.parse(open("https://maps.googleapis.com/maps/api/geocode/json?address=" + URI::encode(@street_address)).read)
    @lat = coordinates["results"][0]["geometry"]["location"]["lat"]
    @lng = coordinates["results"][0]["geometry"]["location"]["lng"]

    weather = JSON.parse(open("https://api.darksky.net/forecast/a4f569fa6c8872b6f37f4c6178f8d120/" + @lat.to_s + "," + @lng.to_s).read)

    @current_temperature = weather["currently"]["temperature"]

    @current_summary = weather["currently"]["summary"]

    @summary_of_next_sixty_minutes = weather["minutely"]["summary"]

    @summary_of_next_several_hours = weather["hourly"]["summary"]

    @summary_of_next_several_days = weather["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
