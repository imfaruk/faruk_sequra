# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { FactoryBot.create(:order) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_numericality_of(:amount) }
  end

  describe 'assocations' do
    it { is_expected.to belong_to(:merchant) }
    it { is_expected.to belong_to(:shopper) }
  end
end
