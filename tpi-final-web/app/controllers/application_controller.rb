class ApplicationController < ActionController::Base
    include Pundit

    before_action :configure_permitted_parameters, if: :devise_controller?
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname])
    end

    private
  
    def user_not_authorized
      flash[:alert] = "No estás autorizado/a para realizar esta acción."
      redirect_to(request.referrer || root_path)
    end
    def record_not_found
      flash[:notice] = "Recurso no encontrado"
      redirect_to books_path
    end

end
