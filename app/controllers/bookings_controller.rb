class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  def index
    @bookings = Booking.all
    @room = Room.all
  end
  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @room = Room.find(params[:room_id])
    @booking = Booking.new
  end

  def create
    if user_signed_in?
      @booking = current_user.bookings.build(booking_params)
      @booking.room = Room.find(params[:room_id])

      if @booking.save
        redirect_to @booking, notice: 'Reserva creada exitosamente.'
      else
        render :new, status: :unprocessable_entity
      end
    else
      # Guardar los datos de la reserva temporalmente en la sesión
      session[:pending_booking] = {
        room_id: params[:room_id],
        booking: booking_params
      }
      # Redirigir al login
      redirect_to new_user_session_path, alert: 'Necesitas iniciar sesión para continuar.'
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
    redirect_to bookings_path(@booking.room), notice: 'Reserva eliminada exitosamente.'
  end

  private

  def booking_params
    params.require(:booking).permit(:date_start, :date_finish)
  end
end
