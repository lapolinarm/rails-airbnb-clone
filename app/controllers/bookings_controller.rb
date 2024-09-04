class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end
  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
    @room = Room.find(params[:room_id])
  end

  def create
    @booking = current_user.bookings.build(booking_params)
    @booking.room = Room.find(params[:room_id])

    if @booking.save
      redirect_to @booking, notice: 'Reserva creada exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  def edit
  @booking = Booking.find(params[:id])
  @room = @booking.room
  end

  def update
    @booking = Booking.find(params[:id])

    if @booking.update(booking_params)
      redirect_to @booking, notice: 'Reserva actualizada exitosamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path, notice: 'Reserva eliminada exitosamente.'
  end

  private

  def booking_params
    params.require(:booking).permit(:date_start, :date_finish)
  end
end
