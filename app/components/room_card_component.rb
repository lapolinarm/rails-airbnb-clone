# frozen_string_literal: true

class RoomCardComponent < ViewComponent::Base
  with_collection_parameter :room

  def initialize(room:)
    super
    @room = room
  end
end
