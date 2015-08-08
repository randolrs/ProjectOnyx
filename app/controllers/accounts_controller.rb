class AccountsController < ApplicationController

	#before_action :set_account, only: [:show, :edit, :update, :destroy]

	def new

	    Stripe.api_key = Rails.configuration.stripe[:publishable_key]
	      Stripe::Account.create(
	        {
	          :country => "US",
	          :managed => true,
	          :transfer_schedule[1] => "manual"
	        }
	      )

	end

	def create

	end

	def update

		@predictor = current_predictor

		Stripe.api_key = @predictor.account_token

		account = Stripe::Account.retrieve(@predictor.account_key_secret)

		account.legal_entity.first_name = params[:firstName]
		account.legal_entity.last_name = params[:lastName]
		#account.legal_entity.dob = params[:dob]
		#account.legal_entity.dob = params[:dob]
		#account.legal_entity.dob = params[:dob]
		account.save

		predictorpayeeedit_path(current_predictor.username)

		redirect_to predictorpayeeedit_path
	end


	def edit

		@action = "payment"

		@predictor = current_predictor

		Stripe.api_key = @predictor.account_token

		@account_object = Stripe::Account.retrieve(@predictor.account_key_secret).legal_entity

		@firstname = @account_object.first_name
		@lastname = @account_object.last_name
		@dob = @account_object.dob

	end

end
