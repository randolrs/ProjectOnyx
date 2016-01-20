class SubscriptionsController < ApplicationController

    def create
    
	    @predictor = Predictor.find_by_username(params[:username])

	    if user_signed_in?

	    	@user = current_user

			Stripe.api_key = Rails.configuration.stripe[:secret_key]

	      	#retrieve and set default source

	      	customer = Stripe::Customer.retrieve(@user.customer_id)

	      	@price = (@predictor.sub_price.to_i * 100)

	      	

	      	customer_subscriptions = customer.subscriptions.all

	    	has_universal_subscription = false

	      	customer_subscriptions.each do |subscriptions|

	      		if subscriptions.id == "futaversal"

	      			has_universal_subscription = true

	      		end

	      	end


	  	if has_universal_subscription

	  		subscription = customer.subscriptions.retrieve(@user.subscription_id)
			subscription.quantity = subscription.quantity + @price
			subscription.save

	  	else

	  		subscription = customer.subscriptions.create(:plan => "futaversal", :quantity => @price)

	  		@user.subscription_id = subscription.id

	  	end
	      								 
		#purchase model entry addition

		if Purchase.exists?(:user_id=> @user.id,:predictor_id=>@predictor.id)

			@purchase = Purchase.where(:user_id=> @user.id,:predictor_id=>@predictor.id)

			@purchase.each do |purchase|
				purchase.update(:premium => true, :active=> true)
			end

		else

			@purchase = Purchase.new

			@purchase.user_id = @user.id

			@purchase.predictor_id = @predictor.id

			@purchase.active = true

			@purchase.premium = true

			@purchase.save        

		end

	      redirect_to root_path

	    end

	 end

end
