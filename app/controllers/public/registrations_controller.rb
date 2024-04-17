class Public::RegistrationsController < ApplicationController
  before_action :configure_sign_up_params, only: [:create]

  def new
  end

  def create
     @customer = Customer.new(configure_sign_up_params)
    if @customer.save
      redirect_to customers_my_page_path
    else
      render 'new'
    end
  end


  def after_sign_up_path_for(resource)
    customers_my_page_path
  end

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys:[:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :password, :password_confirmation])
  end

end
