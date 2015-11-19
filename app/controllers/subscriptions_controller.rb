class SubscriptionsController < ApplicationController

  def create
    
    @predictor = Predictor.find_by_username(params[:username])

    if user_signed_in?

    	@user = current_user

		Stripe.api_key = @predictor.account_key_secret

		###probably should add user_id identifier to customer

		@predictor_customers = Stripe::Customer.all.data

		@predictor_customers.each do |customer|

			if customer.description == @user.id.to_s
				@existing_customer = customer
			end

		end

		if @existing_customer

			customer = Stripe::Customer.retrieve(@existing_customer.id)

		else

	        customer = Stripe::Customer.create(
	                    :description => @user.id,
	                    )
      	end

      	@predictor_plans = Stripe::Plan.all.data

      	@predictor_plans.each do |plan|

			if plan.livemode == true
				@predictor_plan_active = plan
			end

			#need to add way to add active to subscription creation

		end

		####add exception for no active plan

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

		customer.subscriptions.create(:plan => @predictor_plan_active.id)

		@purchase.save        

	end

	#end

      redirect_to root_path

    end
  end

end
