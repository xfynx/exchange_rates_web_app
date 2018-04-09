class ExchangeRateUpdatesChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    stream_from 'exchange_rates'
  end

  def unsubscribed
    stop_all_streams
  end

  class << self
    def update
      ActionCable.server.broadcast(
          'exchange_rates',
          html: ApplicationController.render(partial: 'partials/exchange_rate', collection: ExchangeRate.rates)
      )
    end
  end
end
