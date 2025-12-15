class PagosController < ApplicationController
  def new
    @reserva = ReservaRepository.new.find(params[:reserva_id])
    
    @payment_strategies = [
      Strategies::TarjetaPagoStrategy.new,
      Strategies::TransferenciaPagoStrategy.new,
      Strategies::PagarEnSitioStrategy.new
    ]
  end

  def create
    # El controlador conoce las implementaciones concretas y las inyecta
    use_case = PagarReservaUseCase.new(
      reserva_repo: ReservaRepository.new,
      pago_repo: PagoRepository.new,
      notificador: NotificationService.new
    )
    
    begin

      strategy_class = params[:metodo_pago].constantize
      metodo_pago = strategy_class.new

      use_case.ejecutar(
        reserva_id: params[:reserva_id],
        metodo_pago: metodo_pago
      )
      
      redirect_to historial_path, notice: '¡Pago procesado y reserva confirmada con éxito!'
    rescue ArgumentError, StandardError => e
      redirect_to new_reserva_pago_path(params[:reserva_id]), alert: "Error al procesar el pago: #{e.message}"
    end
  end
end
