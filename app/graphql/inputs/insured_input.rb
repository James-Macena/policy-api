# frozen_string_literal: true

module Inputs
  class InsuredInput < GraphQL::Schema::InputObject
    description 'Insured data to be created'

    argument :name, String, required: true
    argument :document_number, String, required: true
    argument :document_type, String, required: true
  end
end
