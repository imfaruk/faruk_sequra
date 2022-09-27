# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GenerateDisbursementService do
  let(:service_object) { described_class.new(fourth_monday2022, merchant1) }

  let(:second_friday2022) { DateTime.commercial(2022, 2, 5) }
  let(:third_friday2022) { DateTime.commercial(2022, 3, 5) }
  let(:fourth_monday2022) { DateTime.commercial(2022, 4, 1) }

  let!(:disbursement_fee_rule) { FactoryBot.create(:disbursement_fee_rule, percentage: 1.0) }

  let!(:merchant1) { FactoryBot.create(:merchant) }
  let!(:merchant2) { FactoryBot.create(:merchant) }

  before do
    FactoryBot.create(:order, amount: 100, completed_at: nil, merchant: merchant1)
    FactoryBot.create(:order, amount: 200, completed_at: second_friday2022, merchant: merchant1)
    FactoryBot.create(:order, amount: 300, completed_at: third_friday2022, merchant: merchant2)

    FactoryBot.create(:order, amount: 300, completed_at: third_friday2022, merchant: merchant1)
    FactoryBot.create(:order, amount: 400, completed_at: third_friday2022, merchant: merchant1)
  end

  describe '#call' do
    it 'creates a disbursement record considering all orders from previous week' do
      expect { service_object.call }.to change { Disbursement.count }.by(1)
      expect(Disbursement.last.amount).to eq(7.0)
    end
  end
end
