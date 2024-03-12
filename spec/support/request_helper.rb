# frozen_string_literal: true

module FileHelpers
  def load_json(relative_path)
    File.read("#{Rails.root}/#{relative_path}")
  end

  def load_json_symbolized(relative_path)
    data = File.read("#{Rails.root}/#{relative_path}")

    JSON.parse(data, symbolize_names: true)
  end
end

module Stubbs
  def stub_get_policy(args)
    url = "#{ENV.fetch('POLICY_BASE_API_URL')}/policies/#{args[:id]}"

    stub_get(url: url, status: args[:status], response: args[:response])
  end

  def stub_get(url:, status:, response: '')
    stub_request(:get, url).to_return(body: response, status: status)
  end

  def stub_post(url:, params:, status:, response: '')
    stub_request(:get, url)
      .with(body: params)
      .to_return(body: response, status: status)
  end
end

RSpec.configure do
  include FileHelpers
  include Stubbs
end
