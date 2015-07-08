class CardsController < ApplicationController

  def index

    @action = "payment"
      Stripe.api_key = Rails.configuration.stripe[:secret_key]

      @list = Stripe::Customer.retrieve(current_user.customer_id).sources.all(:limit => 3, :object => "card")
  end


end
