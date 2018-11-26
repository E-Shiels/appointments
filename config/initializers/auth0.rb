Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    'dyyTyAyOcqGz074qsUwsHNdtVSYj1HEr',
    ENV['AUTH0_SECRET'],
    'eric-shiels.auth0.com',
    callback_path: '/auth/oauth2/callback',
    authorize_params: {
      scope: 'openid profile'
    }
  )
end
