class Public::RegistrationsController < ApplicationController
  before_action :configure_sign_up_params, if: :devise_controller?

  def new
  end

  def create
    @customer_sign_up = Customer.new
    if @customer_sign_up.save
      flash[:notice] = "Welcome! You have signed up successfully."
      # redirect_to customers_my_page_path
    end
  end


  def after_sign_up_path_for(resource)
    customers_my_page_path
  end

  protected
  #sign_upのストロングパラメーター
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys:[:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number])
  end

end
