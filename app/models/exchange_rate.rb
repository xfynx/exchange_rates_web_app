class ExchangeRate < ApplicationRecord
  validates :currency, presence: true, uniqueness: true
  validates :cbr_id, presence: true, uniqueness: true
  validates :price, presence: true

  after_commit :update_rates

  # триггер обновления информации
  def update_rates
    ExchangeRateUpdatesChannel.update
  end


  class << self
    # массив хэшей с информацией об обменных курсах
    def rates
      Array.wrap(ExchangeRate.all.map{|r| {currency: r.currency, price: r.price, updated_at: r.updated_at}})
    end

    # устанавливаем или обновляем курс валюты
    def set_rate(currency, price, cbr_id, relevant_until=Time.now)
      record = find_or_create_by(currency: currency)
      record.update_attributes(price: price, relevant_until: relevant_until, cbr_id: cbr_id)
    end

    # возвращаем обменный курс для нужной валюты
    def get_rate(currency)
      find_by(currency: currency).price
    end
  end

end
