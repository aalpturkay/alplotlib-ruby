class HomeController < ApplicationController
  allow_unauthenticated_access only: %i[ index ]

  def index
    if authenticated?
      redirect_to posts_path
    end
  end
end
