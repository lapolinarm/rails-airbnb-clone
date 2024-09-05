class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @rooms = Room
      .joins(:reviews)
      .select('rooms.*, AVG(reviews.rating) as average_rating')
      .group('rooms.id')
      .order('average_rating DESC')
      .limit(12)
  end
end
