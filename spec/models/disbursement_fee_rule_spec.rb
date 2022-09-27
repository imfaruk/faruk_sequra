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
end
