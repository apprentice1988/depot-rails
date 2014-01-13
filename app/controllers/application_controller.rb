class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorize
  before_action :set_i18n_locale_from_params
  protected
  	def authorize
  		unless User.find_by(id: session[:user_id])
  			redirect_to login_url, notice: "please log in"
  		end
  	end

  	def set_i18n_locale_from_params
  		if params[:locale]
  			if I18n.available_locales.map(&:to_s).include?(params[:locale])
  				I18n.locale = params[:locale]
  			else
  				flash[:notice] = "#{params[:locale]} translation not available"
  				logger.error flash[:notice]
  			end
  		end
  	end

  	def default_url_options
  		{locale:I18n.locale}
  	end
end
