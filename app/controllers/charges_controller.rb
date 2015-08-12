class ChargesController < ApplicationController

def new

  @action = "funds"
    unless current_user.account_id
      Stripe.api_key = Rails.configuration.stripe[:secret_key]
        account = Stripe::Account.create(
              {:country => "US", :managed => true, :email => @current_user.email,
               :transfer_schedule["interval"] => "manual"}
            )

            current_user.update(:account_id => account.id)
            current_user.update(:account_key_p => account.keys.publishable)
            current_user.update(:account_key_s => account.keys.secret)

    end

end

def create
  # Amount in cents
  @amount = params[:amount].to_i * 100

  Stripe.api_key = Rails.configuration.stripe[:secret_key]

  #Stripe.api_key = current_user.account_key_s


  # if current_user.customer_id

  #   customer = Stripe::Customer.retrieve(current_user.customer_id)

  # else
  #   customer = Stripe::Customer.create(
  #     :email => 'example@stripe.com',
  #     :card  => params[:stripeToken]
  #   )

  #   current_user.update(:customer_id => customer.id)

  # end

    charge = Stripe::Charge.create(
    :source       => params[:stripeToken],
    :amount       => @amount,
    :destination  => current_user.account_id,
    :description  => 'Rails Stripe customer',
    :currency     => 'usd'
  )

  # charge = Stripe::Charge.create(
  #   :customer    => customer.id,
  #   :amount      => @amount,
  #   :description => 'Rails Stripe customer',
  #   :currency    => 'usd'
  # )

  # Stripe::Transfer.create(
  #       #:customer => @user.customer_id,
  #       :amount => @amount,
  #       :currency => "usd",
  #       :destination => current_user.account_id,
  #       :source_transaction => charge.id, 
  #       :description => "Transfer from credit card"
  #     )


  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end

  # purchase = Purchase.create(email: params[:stripeEmail], card: params[:stripeToken], 
  #   amount: params[:amount], description: charge.description, currency: charge.currency,
  #   customer_id: customer.id, product_id: 1)

  # redirect_to purchase


end
