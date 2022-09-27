# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Shopper, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:nif) }

    it { is_expected.to allow_value('email@addresse.foo').for(:email) }
    it { is_expected.to_not allow_value('foo').for(:email) }
  end

  describe 'assocations' do
    it { is_expected.to have_many(:orders) }
  end
end
