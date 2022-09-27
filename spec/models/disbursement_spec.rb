# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Disbursement, type: :model do
  subject { FactoryBot.create(:disbursement) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:calculated_at) }
    it { is_expected.to validate_uniqueness_of(:calculated_at).scoped_to(:merchant_id) }
  end

  describe 'assocations' do
    it { is_expected.to belong_to(:merchant) }
  end
end
