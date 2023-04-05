class SearchShopsController < ApplicationController
  skip_before_action :require_login

  def search
    keyword = params[:keyword]

    if keyword.present?
      client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])
      results = client.spots_by_query(keyword, lat: 34.7024898, lng: 135.4937619, language: 'ja', types: 'shop', region: 'ja')

      @shop_fields = results.map do |result|
        ShopField.new(read(result))
      end
      gon.shopLat = @shop_fields.map(&:latitude)
      gon.shopLng = @shop_fields.map(&:longitude)
      gon.shopname = @shop_fields.map(&:name)
    else
      render :search
    end
  end

  private

  def read(result)
    name = result['name']
    latitude = result['lat']
    longitude = result['lng']
    address = result['formatted_address']
    photo_reference = result['photos'][0]&.photo_reference
    image = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=#{photo_reference}&key=#{ENV['GOOGLE_API_KEY']}"
    { name:, latitude:, longitude:, address:, image: }
  end

end
