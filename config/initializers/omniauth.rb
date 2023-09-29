Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, '590415397459-aevkphkq0dove73f9nfo9kr8euf2a8bs.apps.googleusercontent.com', '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',
    scope: "userinfo.email, userinfo.profile",
    prompt: "select_account"
  end

  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET']
  end
# Make sure POST requests are allowed in OmniAuth
# However, OmniAuth 2.0 now only accepts POST requests so this might be redundant
OmniAuth.config.allowed_request_methods = %i[post]
# To silence the warning about allowing get requests
OmniAuth.config.silence_get_warning = true