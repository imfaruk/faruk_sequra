# frozen_string_literal: true

class Merchant < ApplicationRecord
  EMAIL_REGEX = /\A\S+@.+\.\S+\z/

  validates :email, presence: true, format: { with: EMAIL_REGEX, message: 'invalid email' }
  validates :cif, presence: true # TODO: we could validate pattern if there any

  has_many :disbursements
  has_many :orders
end
