class RoomsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show] # Permitir acceso a index y show sin login
  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
    @reviews = @room.reviews
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to @room, notice: 'La habitación fue creada exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to @room, notice: 'La habitación se actualizó correctamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_path, notice: 'La habitación fue eliminada exitosamente.'
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :address, :capacity_max, :pets, :wifi, :parking, :price)
  end
end
