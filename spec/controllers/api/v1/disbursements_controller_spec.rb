# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::DisbursementsController, type: :controller do
  describe 'GET #index' do
    let!(:merchant1) { FactoryBot.create(:merchant, email: 'm1@merchant.com') }
    let!(:merchant2) { FactoryBot.create(:merchant, email: 'm2@merchant.com') }
    let!(:merchant1_disbursement1) do
      FactoryBot.create(
        :disbursement,
        merchant: merchant1,
        calculated_at: DateTime.commercial(2022, 10, 1)
      )
    end

    let!(:merchant1_disbursement2) do
      FactoryBot.create(
        :disbursement,
        merchant: merchant1,
        calculated_at: DateTime.commercial(2022, 11, 1)
      )
    end

    let!(:merchant2disbursement1) do
      FactoryBot.create(
        :disbursement,
        merchant: merchant2,
        calculated_at: DateTime.commercial(2022, 10, 1)
      )
    end

    it 'returns all disbursements from a given week without specific merchant' do
      get :index, params: { year: 2022, week: 10 }

      disbursement_ids = JSON.parse(response.body).map { |i| i['id'] }

      expect(disbursement_ids).to match_array([merchant1_disbursement1.id, merchant2disbursement1.id])
    end

    it 'returns disbursements from a given week for given merchant' do
      get :index, params: { year: 2022, week: 10, merchant_id: merchant1.id }

      parsed_response = JSON.parse(response.body)

      expect(parsed_response['merchant_id']).to eq(merchant1.id)
    end
  end
end
