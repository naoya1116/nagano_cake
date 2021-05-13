# frozen_string_literal: true

class Devise::Customer::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_customer, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def reject_customer
    # puts "test"
    @customer = Customer.find_by(email: params[:customer][:email].downcase)
    if @customer
      # p @customer.valid_password?(params[:customer][:password])
      # p @customer.active_for_authentication?
      if (@customer.valid_password?(params[:customer][:password]) && (!@customer.active_for_authentication?))
        # puts "test1"
        #&&=aとbが共に真の場合に真
        flash[:danger] = "退会済みです。"
        redirect_to new_customer_session_path
      end
    else
      # puts "test3"
      redirect_to items_path
    end
  end


end
