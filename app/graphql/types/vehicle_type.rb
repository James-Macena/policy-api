# frozen_string_literal: true

module Types
  class VehicleType < BaseObject
    field :model, String, null: false
    field :make, String, null: false
    field :plate, String, null: false
    field :year, String, null: false
  end
end
