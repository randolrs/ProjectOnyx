class AccountsController < ApplicationController

def new

    Stripe.api_key = Rails.configuration.stripe[:publishable_key]
      Stripe::Account.create(
        {
          :country => "US",
          :managed => true
        }
      )

end

def create

    


end
