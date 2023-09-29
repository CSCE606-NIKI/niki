Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
    scope: "userinfo.email, userinfo.profile",
    prompt: "select_account"
  end
# Make sure POST requests are allowed in OmniAuth
# However, OmniAuth 2.0 now only accepts POST requests so this might be redundant
OmniAuth.config.allowed_request_methods = %i[post]
# To silence the warning about allowing get requests
OmniAuth.config.silence_get_warning = true