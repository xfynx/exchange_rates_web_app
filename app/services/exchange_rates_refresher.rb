class ExchangeRatesRefresher
  require 'rest-client'

  # ищем контейнеры по ID, например эти да для Доллара и Евро соответственно:
  # <Valute ID="R01235"><NumCode>840</NumCode><CharCode>USD</CharCode><Nominal>1</Nominal><Name>Доллар США</Name><Value>59,0657</Value></Valute>
  # <Valute ID="R01239"><NumCode>978</NumCode><CharCode>EUR</CharCode><Nominal>1</Nominal><Name>Евро</Name><Value>67,6184</Value></Valute>

  def self.perform
    Rails.logger.tagged('RefreshExchangeRates') do
      Rails.logger.info('===start===')
      begin
        date = Date.today.strftime('%d.%m.%Y')
        Rails.logger.info("запрашиваем курс валют на #{date}")
        response = RestClient.get("http://www.cbr.ru/scripts/XML_daily.asp?date_req=#{date}").body
        response = Nokogiri::XML(response)
        ExchangeRate.all.each do |er|
          next if er.relevant_until.present? && Time.now < er.relevant_until
          Rails.logger.info("обновляем #{er.currency}")
          val = response.xpath("//*[@ID=\"#{er.cbr_id}\"]//Value").text.to_s
          if val.present?
            # важно заменить запятые на точки, иначе при конвертировании to_f произойдёт округление до целых
            val=val.sub(',', '.').to_f
            Rails.logger.info("#{er.currency}: #{val}")
            er.price = val; er.relevant_until=Time.now
            er.save!
          else
            Rails.logger.info("не найдено валюты с cbr_id=#{er.cbr_id}")
          end
        end
      ensure
        Rails.logger.info('===end===')
      end
    end
  end
end
