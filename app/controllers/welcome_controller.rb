class WelcomeController < ApplicationController
  allow_unauthenticated_access
  def index
    images = [
      helpers.asset_path("image1.jpg"),
      helpers.asset_path("image2.png"),
      helpers.asset_path("image3.jpg"),
      helpers.asset_path("image4.webp")
    ]
    @background_image = images.sample
  end
end
