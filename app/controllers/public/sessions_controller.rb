class Public::SessionsController < ApplicationController

  def create
    redirect_to root_path
  end

  def destroy
    redirect_to new_customer_session_path
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
