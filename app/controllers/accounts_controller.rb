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

		account_object = account.legal_entity

		account_object.type = params[:payeeType]

		unless params[:firstName] == ""
			account_object.first_name = params[:firstName]
		end

		unless params[:lastName] == ""
			account_object.last_name = params[:lastName]
		end

		@dob = params[:dobDate]

		@dobYear = @dob[0..3]
		@dobMonth = @dob[5..6]
		@dobDay = @dob[8..10]

		account_object["dob"]["year"] = @dobYear
		account_object["dob"]["month"] = @dobMonth
		account_object["dob"]["day"] = @dobDay

		account.save

		@accountType = account_object.type

		@dob_object = account_object.dob

		if @dob_object["month"].to_s.length == 1

			@dob_month = "0" + @dob_object["month"].to_s

		else

			@dob_month = @dob_object["month"].to_s

		end

		if @dob_object["day"].to_s.length == 1 

			@dob_day = "0" + @dob_object["day"].to_s

		else

			@dob_day = @dob_object["day"].to_s

		end

		@dob_year = @dob_object["year"].to_s


		predictorpayeeedit_path(current_predictor.username)

		redirect_to predictorpayeeedit_path
	end


	def edit

		@action = "payment"

		@predictor = current_predictor

		Stripe.api_key = @predictor.account_token

		@account_object = Stripe::Account.retrieve(@predictor.account_key_secret).legal_entity

		@accountType = @account_object.type
		@firstname = @account_object.first_name
		@lastname = @account_object.last_name
		@dob_object = @account_object.dob

		if @dob_object["month"].to_s.length == 1

			@dob_month = "0" + @dob_object["month"].to_s

		else

			@dob_month = @dob_object["month"].to_s

		end

		if @dob_object["day"].to_s.length == 1 

			@dob_day = "0" + @dob_object["day"].to_s

		else

			@dob_day = @dob_object["day"].to_s

		end

		@dob_year = @dob_object["year"].to_s

	end

end
