# frozen_string_literal: true

class Shopper < ApplicationRecord
  EMAIL_REGEX = /\A\S+@.+\.\S+\z/

  validates :email, presence: true, format: { with: EMAIL_REGEX, message: 'invalid email' }
  validates :nif, presence: true # TODO: we could validate pattern if there any

  has_many :orders
end
