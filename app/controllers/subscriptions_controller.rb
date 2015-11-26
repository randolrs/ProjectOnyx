class SubscriptionsController < ApplicationController

  def create
    
    @predictor = Predictor.find_by_username(params[:username])

    if user_signed_in?

    	@user = current_user

		Stripe.api_key = Rails.configuration.stripe[:secret_key]


      	#retrieve and set default source

      	customer_token = Stripe::Token.create(
					  			{:customer => @user.customer_id},
					  			{:stripe_account => @predictor.account_id}
							)

      	Stripe.api_key = @predictor.account_key_secret

      	customer = Stripe::Customer.create(
	                    :description => @user.id,
	                    :source => customer_token.id
	                    )

      	customer.subscriptions.create(:plan => @predictor.subscription_id,
      								  :application_fee_percent => 20)

      	#application_fee_percent should become dynsamic later


	#purchase model entry addition

	if Purchase.exists?(:user_id=> @user.id,:predictor_id=>@predictor.id)

		@purchase = Purchase.where(:user_id=> @user.id,:predictor_id=>@predictor.id)

		@purchase.each do |purchase|
			purchase.update(:premium => true)
		end

	else

		@purchase = Purchase.new

		@purchase.user_id = @user.id

		@purchase.predictor_id = @predictor.id

		@purchase.price = @predictor.subscription_price

		@purchase.next_payment = Time.now + 31.days

		@purchase.premium = true

		@purchase.save        

	end

      redirect_to root_path

    end
  end

end
