class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  # Redirige después de iniciar sesión y crea la reserva si es necesario
  def after_sign_in_path_for(resource)
    if session[:pending_booking]
      create_pending_booking # Crea la reserva con los datos almacenados
    else
      super # Redirige al lugar por defecto si no hay reserva pendiente
    end
  end

  private

  def create_pending_booking
    pending_booking = session.delete(:pending_booking)
    @booking = Booking.new(pending_booking[:booking])
    @booking.user = current_user
    @booking.room = Room.find(pending_booking[:room_id])

    if @booking.save
      redirect_to @booking, notice: 'Reserva creada con éxito después de iniciar sesión.'
    else
      redirect_to new_booking_path(room_id: pending_booking[:room_id]), alert: 'Ocurrió un problema al crear la reserva. Por favor, intenta de nuevo.'
    end
  end
end
