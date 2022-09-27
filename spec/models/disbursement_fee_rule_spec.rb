# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DisbursementFeeRule, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:upper_bound) }
    it { is_expected.to validate_presence_of(:lower_bound) }
    it { is_expected.to validate_presence_of(:percentage) }

    describe '#upper_and_lower_limit' do
      let!(:rule) { FactoryBot.create(:disbursement_fee_rule, lower_bound: 0.0, upper_bound: 10.0) }
      let(:another_rule) { FactoryBot.build(:disbursement_fee_rule, lower_bound: 5, upper_bound: 15.0) }

      specify do
        expect(another_rule).to be_invalid
      end
    end

    describe '#upper_is_greater_than_lower' do
      let(:rule) { FactoryBot.build(:disbursement_fee_rule, lower_bound: 50, upper_bound: 15.0) }

      specify do
        expect(rule).to be_invalid
      end
    end
  end

  describe '.amount_to_disburse' do
    let!(:rule1) { FactoryBot.create(:disbursement_fee_rule, lower_bound: 0.0, upper_bound: 100.0, percentage: 1.0) }
    let!(:rule2) { FactoryBot.create(:disbursement_fee_rule, lower_bound: 101.0, upper_bound: 200.0, percentage: 2.0) }

    it 'returns the disbursed amount by applying the matching rule' do
      expect(described_class.amount_to_disburse(100)).to eq(1)
      expect(described_class.amount_to_disburse(200)).to eq(4)
    end
  end
end
