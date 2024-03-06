# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  post '/graphql',          to: 'graphql/base#execute'
  get  '/graphiql',         to: 'graphql/base#graphiql'
  get  '/graphql/describe', to: 'graphql/base#describe'
end
