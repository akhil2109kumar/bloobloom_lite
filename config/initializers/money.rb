# frozen_string_literal: true

MoneyRails.configure do |config|
  # To set the default currency
  config.default_currency = :usd

  config.add_rate 'USD', 'EUR', 0.94
  config.add_rate 'USD', 'GBP', 0.81
  config.add_rate 'USD', 'JOD', 0.71
  config.add_rate 'USD', 'JPY', 154.69
end
