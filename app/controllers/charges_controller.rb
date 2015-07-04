class ChargesController < ApplicationController

def new

    unless current_user.account_id
      Stripe.api_key = Rails.configuration.stripe[:secret_key]
        account = Stripe::Account.create(
              {:country => "US", :managed => true, :email => @current_user.email}
            )

            current_user.update(:account_id => account.id)
            current_user.update(:account_key_p => account.keys.publishable)
            current_user.update(:account_key_s => account.keys.secret)

    end

end

def create
  # Amount in cents
  @amount = params[:amount].to_i * 100

  if current_user.customer_id

    customer = Stripe::Customer.retrieve(current_user.customer_id)

  else
    customer = Stripe::Customer.create(
      :email => 'example@stripe.com',
      :card  => params[:stripeToken]
    )

    current_user.update(:customer_id => customer.id)

  end

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Rails Stripe customer',
    :currency    => 'usd'
  )

  customer.sources.create({:source => params[:stripeToken]})

  @new_balance = current_user.balance + @amount/100
  current_user.update(:balance => @new_balance)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end


end
