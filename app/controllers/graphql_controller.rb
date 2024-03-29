# frozen_string_literal: true

class GraphqlController < ApplicationController
  def execute
    result = PolicyApiSchema.execute(
      params[:query],
      variables: prepare_variables(params[:variables]),
      context: { auth_token: auth_token },
      operation_name: params[:operationName]
    )

    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development(e)
  end

  private

  # Handle variables in form data, JSON body, or a blank value
  # rubocop: disable Metrics/MethodLength
  def prepare_variables(variables_param)
    case variables_param
    when String
      JSON.parse(variables_param) || {}
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end
  # rubocop: enable Metrics/MethodLength

  def handle_error_in_development(error)
    logger.error error.message
    logger.error error.backtrace.join("\n")

    render json: { errors: [{ message: error.message, backtrace: error.backtrace }], data: {} }, status: 500
  end
end
