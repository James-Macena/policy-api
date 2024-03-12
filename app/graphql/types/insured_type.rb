# frozen_string_literal: true

module Types
  class InsuredType < BaseObject
    field :name, String, null: false
    field :document_number, String, null: false
    field :document_type, String, null: false
  end
end
