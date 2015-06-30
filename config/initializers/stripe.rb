Rails.configuration.stripe = {
	:publishable_key => 'pk_test_84CnnHh167RuKOzzorfKCAMW',
  	:secret_key      => 'sk_test_svAKZ4nK4zbOCF62LZHGzOAL'
  # :publishable_key => ENV['PUBLISHABLE_KEY'],
  # :secret_key      => ENV['SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
