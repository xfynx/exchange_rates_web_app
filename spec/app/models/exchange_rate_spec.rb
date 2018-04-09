require 'spec_helper'

describe ExchangeRate do
  it do
    described_class.set_rate('111', 1, '222')
    expect(described_class.get_rate('111')).to eq(1)
    expect{described_class.get_rate('222')}.to raise_exception
    date=DateTime.parse('2017-01-01')
    described_class.set_rate('qwe', 1, '2221', date)
    expect(described_class.find_by(currency: 'qwe').relevant_until).to eq(date)
  end
end