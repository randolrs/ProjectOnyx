class BankAccountsController < ApplicationController

	def new

		@predictor = current_predictor

		@action = "bank"

     	Stripe.api_key = Rails.configuration.stripe[:secret_key]

      	@account = Stripe::Account.retrieve(@predictor.account_id)

      	#@defaultaccount = @account.external_accounts.all(:object => "bank_account", :def_currency => true)

      	@bankaccountlist = @account.external_accounts.all(:object => "bank_account", :limit => 5)

      	@accounts = @bankaccountlist.data

	end

	def create
		@account_id = current_predictor.account_id
		
		#bank_account = account.external_accounts.create({:external_account => "S2XuxGsEJ33CDIaqHV8Mzu9e"})
		
		token = Stripe::Token.create(
    		:bank_account => {
		    :country => params[:country],
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
		redirect_to edit_predictor_registration_path
	end

end
