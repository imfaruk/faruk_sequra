# frozen_string_literal: true

module Api
  module V1
    class DisbursementsController < ApplicationController
      def index
        @disbursements = GetDisbursementsService.call(week:, year:, merchant_id:)
        render json: @disbursements
      end

      private

        def query_params
          params.permit(:year, :week, :merchant_id)
        end

        def year
          query_params[:year].to_i
        end

        def week
          query_params[:week].to_i
        end

        def merchant_id
          return nil unless query_params[:merchant_id].present?

          query_params[:merchant_id].to_i
        end
    end
  end
end
