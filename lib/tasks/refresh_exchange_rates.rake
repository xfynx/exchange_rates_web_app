desc 'обновить курсы валют'
task refresh_exchange_rates: :environment do
  ExchangeRatesRefresher.perform
end