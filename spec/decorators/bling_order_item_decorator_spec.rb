# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BlingOrderItemDecorator, type: :decorator do
  let(:bling_order) { FactoryBot.create(:bling_order_item) }
  let(:bling_order_id) { bling_order.bling_order_id }
  let(:bling_order_decorated) { bling_order.decorate }

  describe '#title' do
    it 'decorates bling_order_id' do
      title = "#{t('activerecord.attributes.bling_order_items.bling_order_id')} #{bling_order_id}"
      expect(bling_order_decorated.title).to eq(title)
    end
  end

  describe '#situation_id' do
    it 'is humanized' do
      expect(bling_order_decorated.situation_id).to eq(t('enumerations.bling_order_item_status.checked'))
    end
  end

  describe '#store_id' do
    it 'is humanized' do
      expect(bling_order_decorated.store_id).to eq('Shein')
    end
  end

  describe '#created_at' do
    it 'uses default locales' do
      expect(bling_order_decorated.created_at).to eq(localize(bling_order.created_at, format: :default))
    end
  end

  describe '#updated_at' do
    it 'uses default locales' do
      expect(bling_order_decorated.updated_at).to eq(localize(bling_order.updated_at, format: :default))
    end
  end

  describe '#date' do
    it 'uses default locales' do
      expect(bling_order_decorated.date).to eq(localize(bling_order.date, format: :short))
    end
  end

  describe '#alteration_date' do
    context 'when there is alteration date' do
      it 'uses short locales' do
        expect(bling_order_decorated.alteration_date).to eq(localize(bling_order.alteration_date, format: :short))
      end
    end

    context 'when alteration date is blank' do
      before { bling_order.alteration_date = nil }

      it 'shows warning about blank alteration date' do
        expect(bling_order_decorated.alteration_date).to be_blank
      end
    end
  end
end
