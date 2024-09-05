class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    # @featured_rooms = Room
    @rooms = Room
      .joins(:reviews)
      .select('rooms.*, AVG(reviews.rating) as average_rating')
      .group('rooms.id')
      .order('average_rating DESC')
      .limit(5)
  end
end
