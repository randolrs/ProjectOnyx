class BankAccountsController < ApplicationController

	def new

		@predictor = current_predictor

		@action = "Add Bank Account"
		

	end

	def create
		@account_id = current_predictor.account_id

		
		#bank_account = account.external_accounts.create({:external_account => "S2XuxGsEJ33CDIaqHV8Mzu9e"})
		

		token = Stripe::Token.create(
    		:bank_account => {
		    :country => "US",
		    :display_name => params[:description],
		    :bank_name => params[:bankName],
		    :routing_number => params[:routingNumber],
		    :account_number => params[:accountNumber],
  			},
		)

		@token_id = token.id

		account = Stripe::Account.retrieve(@account_id)
		bank_account = account.external_accounts.create({:external_account => @token_id})
		#bank_account = account.external_accounts.create({:external_account => Rails.configuration.stripe[:publishable_key]})

	end

end
