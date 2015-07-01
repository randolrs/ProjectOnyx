class ChargesController < ApplicationController

def new

end

def create
  # Amount in cents
  @amount = params[:amount].to_i * 100

  customer = Stripe::Customer.create(
    :email => 'example@stripe.com',
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Rails Stripe customer',
    :currency    => 'usd'
  )

  @new_balance = current_user.balance + @amount/100
  current_user.update(:balance => @new_balance)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end


end
