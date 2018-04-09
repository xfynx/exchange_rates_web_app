require 'spec_helper'

describe ExchangeRatesRefresher do
  let(:cbr_response) { File.read('spec/fixtures/cbr_response.xml') }

  before(:all) { Timecop.freeze(DateTime.parse('09.04.2018')) }
  before do
    ExchangeRate.set_rate('EUR', 80, 'R01239')
    # не обновится, т.к. данные ещё актуальны до завтра
    ExchangeRate.set_rate('USD', 60, 'R01235', Date.tomorrow)
    # не обновится ввиду несуществующего cbr_id
    ExchangeRate.set_rate('some', 111, 'no-id')
  end
  after(:all) { Timecop.return }

  describe '#perform' do
    context 'удачное обновление' do
      before do
        stub_request(:get, "http://www.cbr.ru/scripts/XML_daily.asp?date_req=#{Date.today.strftime('%d.%m.%Y')}")
            .to_return(status: 200, body: cbr_response)
      end

      it 'должен обновить только курс валюты, где релевантность истекла и cbr_id существует' do
        expect(ExchangeRate.get_rate('USD')).to eq(60)
        expect(ExchangeRate.get_rate('EUR')).to eq(80)
        expect(ExchangeRate.get_rate('some')).to eq(111)
        expect { described_class.perform }.not_to change { ExchangeRate.count }
        expect(ExchangeRate.get_rate('USD')).to eq(60)
        expect(ExchangeRate.get_rate('EUR')).to eq(70.7069)
        expect(ExchangeRate.get_rate('some')).to eq(111)
      end
    end

    context 'неудачное обновление' do
      before do
        stub_request(:get, "http://www.cbr.ru/scripts/XML_daily.asp?date_req=#{Date.today.strftime('%d.%m.%Y')}")
      end
      it 'не должен обновить вообще ничего, если ответ CBR.ru не получен' do
        expect(ExchangeRate.get_rate('USD')).to eq(60)
        expect(ExchangeRate.get_rate('EUR')).to eq(80)
        expect(ExchangeRate.get_rate('some')).to eq(111)
        described_class.perform
        expect(ExchangeRate.get_rate('USD')).to eq(60)
        expect(ExchangeRate.get_rate('EUR')).to eq(80)
        expect(ExchangeRate.get_rate('some')).to eq(111)
      end
    end
  end

end