class ApplicationController < ActionController::Base
  before_action :set_locale

  private

  def set_locale
    if params[:locale] && I18n.available_locales.include?(params[:locale].to_sym)
      session[:locale] = params[:locale].to_sym
    end
    I18n.locale = session[:locale] || I18n.default_locale
  end
end
