class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  protected

	  def configure_devise_permitted_parameters
	    registration_params = [:username, :image, :name, :email, :password, :password_confirmation, :balance, :bio, :account, 
	    	:account_id, :account_token, :account_key_p, :account_key_s, :customer_id, :subscription_id]

	    if params[:action] == 'update'
	      devise_parameter_sanitizer.for(:account_update) { 
	        |u| u.permit(registration_params << :current_password)
	      }
	    elsif params[:action] == 'create'
	      devise_parameter_sanitizer.for(:sign_up) { 
	        |u| u.permit(registration_params) 
	      }

	    end

	  end

	  def after_sign_in_path_for(predictor)
	  	
	  	if predictor_signed_in?

  			predictordashboard_path(current_predictor.username)

  		elsif user_signed_in?

  			unless current_user.customer_id

          Stripe.api_key = Rails.configuration.stripe[:secret_key]

  				customer = Stripe::Customer.create(
                    :description => "Customer for Onyx",
                    #:source => params[:stripeToken] # obtained with Stripe.js
                    )

  				current_user.update(:customer_id => customer.id)

  			end

  			root_path

  		elsif admin_signed_in?

  			gamedash_path

  		end

	end

end
